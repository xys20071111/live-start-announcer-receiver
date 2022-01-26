import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.PushNotifications 0.1
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'bla.xys'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('B站直播开始通知')
        }

        Label {
            id: a
            anchors.top: header.bottom
            anchors.topMargin: 5
            text: "弹幕机器人API端口"
        }
        TextField {
            anchors.top: a.bottom
            anchors.topMargin: 5
            id:port
            width:800
            height: 112
            text:"7788"
        }

        Label {
            id: b
            anchors.top: port.bottom
            anchors.topMargin: 5
            x: 36
            y: 320
            text: "弹幕机器人API认证码"
        }
        TextField {
            anchors.top: b.bottom
            anchors.topMargin: 5
            id:token
            width:800
            height: 112
            text:"crnmsmshsa"
        }
        Label {
            id: c
            anchors.top: token.bottom
            anchors.topMargin: 5
            x: 36
            y: 320
            text: "你的 Push Token"
        }
        TextField {
            anchors.top: c.bottom
            anchors.topMargin: 5
            id:pushToken
            width:800
            height: 112
            text:""
            readOnly: true
        }
        Button {
            anchors.top: pushToken.bottom
            text: "生成配置文件"
            color: UbuntuColors.green
            onClicked: {
                python.importModule_sync('generateConfig');
                python.call_sync("generateConfig.generate",[parseInt(port.text, 10), token.text, pushClient.token])
            }
        }
    }

    PushClient {
        id: pushClient
        appId: "bla.xys_main"
        onTokenChanged: {console.log("👍", pushClient.token); pushToken.text = pushClient.token}
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../src/'));
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }

}
