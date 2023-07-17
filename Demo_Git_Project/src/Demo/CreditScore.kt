package com.i2c.mcpcc.creditscore.fragments

import android.os.Bundle
import android.text.Html
import android.text.SpannableStringBuilder
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import com.i2c.mcpcc.R
import com.i2c.mcpcc.creditscore.model.CreditScoreHtml
import com.i2c.mcpcc.creditscore.services.CreditScoreServices
import com.i2c.mcpcc.databinding.FragmentCreditScoreBinding
import com.i2c.mcpcc.fragment.MCPBaseFragment
import com.i2c.mcpcc.loadfundsmulticurrency.dao.PurseLoadFundsResponse
import com.i2c.mcpcc.loadfundsmulticurrency.fragments.MultiLoadFndsPurseSelection
import com.i2c.mcpcc.loadfundsmulticurrency.services.MultiCurrencyLoadFundsServices
import com.i2c.mcpcc.model.TermsConditionResponse
import com.i2c.mcpcc.modulecontainer.fragments.ModuleContainer
import com.i2c.mcpcc.registercard.response.TermsAndConditionsResponse
import com.i2c.mcpcc.utils.AppConstant
import com.i2c.mcpcc.utils.DBConstants
import com.i2c.mcpcc.utils.Methods
import com.i2c.mobile.base.constants.TalkbackConstants
import com.i2c.mobile.base.databases.PropertyId
import com.i2c.mobile.base.manager.AppManager
import com.i2c.mobile.base.menu.DashboardMenuItem
import com.i2c.mobile.base.model.KeyValuePair
import com.i2c.mobile.base.networking.callback.RetrofitCallback
import com.i2c.mobile.base.networking.response.ResponseCodes
import com.i2c.mobile.base.networking.response.ServerResponse
import com.i2c.mobile.base.selector.callback.DataFetcherCallback
import com.i2c.mobile.base.util.BaseMethods
import com.i2c.mobile.base.widget.HTMLWidget
import java.util.*

class CreditScore : MCPBaseFragment, DataFetcherCallback {
    private lateinit var binding: FragmentCreditScoreBinding

    constructor()

    var termDataArray = HashMap<String, Any>()
    override fun onCreate(savedInstanceState: Bundle?) {
        vc_id = javaClass.simpleName
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        contentView = inflater.inflate(R.layout.fragment_credit_score, container, false)
        binding = DataBindingUtil.bind(contentView)!!
        return binding.root
    }
	
	override fun onCreateViews(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        contentView = inflater.inflate(R.layout.fragment_credit_score, container, false)
        binding = DataBindingUtil.bind(contentView)!!
        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        fetchTermsAndConditionRequest()
    }

    override fun onDataFetched(dataSet: MutableList<KeyValuePair>?) {
        val menuItem = DashboardMenuItem()
        menuItem.webViewTaskId = AppConstant.TaskIds.WEB_VIEW_FRAGMENT
        val moduleContainer = BaseMethods.getWebViewActivity(activity, menuItem) as ModuleContainer

        if (null != moduleContainer) {
            val spanUrl = dataSet!![0].value
            val title = dataSet[1].value
//            if (fileExtensionTermsAndCond.equals(HTMLWidget.KEY_HTML, ignoreCase = true) && termDataArray.containsKey(spanUrl)) {
            moduleContainer.addData(HTMLWidget.KEY_HTML,termDataArray.get(spanUrl).toString())
//            } else if (fileExtensionTermsAndCond.equals(HTMLWidget.KEY_PDF, ignoreCase = true) && termDataArray.containsKey(spanUrl)) {
//                val termsConditionResponse = TermsAndConditionsResponse()
//                termsConditionResponse.fileBytesData = termsAndCondData
//                moduleContainer.addSharedDataObj(HTMLWidget.KEY_PDF, termsConditionResponse)
//            }
//
            moduleContainer.addData(HTMLWidget.KEY_TITLE, title)
            addFragmentOnTop(moduleContainer)
        }

    }

    private fun fetchTermsAndConditionRequest() {
        val service = AppManager.getServiceManager().getService(CreditScoreServices::class.java)
        val call = service.fetchCreditScoreDetails() //amountSelector.getText()
        showProgressDialog()
        call.enqueue(object : RetrofitCallback<ServerResponse<CreditScoreHtml?>?>(activity) {
            override fun onError(responseCode: ResponseCodes) {
                super.onError(responseCode)
                hideProgressDialog()
            }

            override fun onSuccess(serverResponse: ServerResponse<CreditScoreHtml?>?) {
                hideProgressDialog()
                serverResponse?.responsePayload?.let {
                    initDataForHTML(it)
                }
            }
        })
    }


    private fun initDataForHTML(creditScoreHtml: CreditScoreHtml) {

//        var htmlWidget = (binding.creditHtmlWidget.widgetView as HTMLWidget)

        var creditHtmlWidget  = (binding.creditHtmlWidget.widgetView as HTMLWidget)
        var htmlMsg = ""

        if (creditScoreHtml.faqs == null) {
            htmlMsg = "13378"
        }
        if (creditScoreHtml.terms == null) {
            htmlMsg = "13377"
        }

        if (creditScoreHtml.faqs == null && creditScoreHtml.terms == null) {
            (binding.creditHtmlWidget.widgetView as HTMLWidget).visibility = View.GONE
        }

        creditScoreHtml.faqs?.let {
            termDataArray.put(AppConstant.Keys.A_HTML, it)
        }

        creditScoreHtml.terms?.let {
            termDataArray.put(AppConstant.Keys.B_HTML, it)
        }

        if (!Methods.isNullOrEmptyString(htmlMsg)){
            creditHtmlWidget.putPropertyValue(PropertyId.LBL_MSG_ID.propertyId,Methods.getMessages(activity,htmlMsg))
            creditHtmlWidget.updatePlaceHolderValue()

        }
        (binding.creditHtmlWidget.widgetView as HTMLWidget).initData(termDataArray, this);
    }


}