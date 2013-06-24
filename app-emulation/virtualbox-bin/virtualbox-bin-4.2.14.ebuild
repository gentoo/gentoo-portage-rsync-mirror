# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-bin/virtualbox-bin-4.2.14.ebuild,v 1.1 2013/06/24 10:53:10 polynomial-c Exp $

EAPI=5

inherit eutils unpacker fdo-mime gnome2 pax-utils udev

MY_PV=${PV/beta/BETA}
MY_PV=${MY_PV/rc/RC}
VBOX_PV=${MY_PV}-86644
SDK_PV=${VBOX_PV}
EXTP_PV=${SDK_PV}
MY_P=VirtualBox-${VBOX_PV}-Linux
EXTP_PN=Oracle_VM_VirtualBox_Extension_Pack

DESCRIPTION="Family of powerful x86 virtualization products for enterprise as well as home use"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="amd64? ( http://download.virtualbox.org/virtualbox/${MY_PV}/${MY_P}_amd64.run )
	x86? ( http://download.virtualbox.org/virtualbox/${MY_PV}/${MY_P}_x86.run )
	sdk? ( http://download.virtualbox.org/virtualbox/${MY_PV}/VirtualBoxSDK-${SDK_PV}.zip )
	http://download.virtualbox.org/virtualbox/${MY_PV}/${EXTP_PN}-${EXTP_PV}.vbox-extpack -> ${EXTP_PN}-${EXTP_PV}.tar.gz"

LICENSE="GPL-2 PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+additions +chm headless python sdk vboxwebsrv rdesktop-vrdp"
RESTRICT="mirror"

DEPEND="app-arch/unzip"

RDEPEND="!!app-emulation/virtualbox
	!app-emulation/virtualbox-additions
	~app-emulation/virtualbox-modules-${PV}
	!headless? (
		x11-libs/libXcursor
		media-libs/libsdl[X]
		x11-libs/libXrender
		x11-libs/libXfixes
		media-libs/libpng
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXinerama
		x11-libs/libXft
		media-libs/freetype
		media-libs/fontconfig
		x11-libs/libXext
		dev-libs/glib
		chm? ( dev-libs/expat )
	)
	x11-libs/libXt
	dev-libs/libxml2
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXdmcp
	python? ( || (
			dev-lang/python:2.7
			dev-lang/python:2.6
			dev-lang/python:2.5
		) )"

S=${WORKDIR}

QA_TEXTRELS_amd64="opt/VirtualBox/VBoxVMM.so"
QA_TEXTRELS_x86="opt/VirtualBox/VBoxGuestPropSvc.so
	opt/VirtualBox/VBoxSDL.so
	opt/VirtualBox/VBoxDbg.so
	opt/VirtualBox/VBoxSharedFolders.so
	opt/VirtualBox/VBoxDD2.so
	opt/VirtualBox/VBoxOGLrenderspu.so
	opt/VirtualBox/VBoxPython.so
	opt/VirtualBox/VBoxPython2_5.so
	opt/VirtualBox/VBoxPython2_6.so
	opt/VirtualBox/VBoxPython2_7.so
	opt/VirtualBox/VBoxDD.so
	opt/VirtualBox/VBoxVRDP.so
	opt/VirtualBox/VBoxDDU.so
	opt/VirtualBox/VBoxREM64.so
	opt/VirtualBox/VBoxSharedClipboard.so
	opt/VirtualBox/VBoxHeadless.so
	opt/VirtualBox/VBoxRT.so
	opt/VirtualBox/VRDPAuth.so
	opt/VirtualBox/VBoxREM.so
	opt/VirtualBox/VBoxSettings.so
	opt/VirtualBox/VBoxKeyboard.so
	opt/VirtualBox/VBoxSharedCrOpenGL.so
	opt/VirtualBox/VBoxVMM.so
	opt/VirtualBox/VirtualBox.so
	opt/VirtualBox/VBoxOGLhosterrorspu.so
	opt/VirtualBox/components/VBoxC.so
	opt/VirtualBox/components/VBoxSVCM.so
	opt/VirtualBox/VBoxREM32.so
	opt/VirtualBox/VBoxPython2_5.so
	opt/VirtualBox/VBoxXPCOMC.so
	opt/VirtualBox/VBoxOGLhostcrutil.so
	opt/VirtualBox/VBoxNetDHCP.so
	opt/VirtualBox/VBoxGuestControlSvc.so"
QA_PRESTRIPPED="opt/VirtualBox/VBoxDD.so
	opt/VirtualBox/VBoxDD2.so
	opt/VirtualBox/VBoxDDU.so
	opt/VirtualBox/VBoxDbg.so
	opt/VirtualBox/VBoxGuestControlSvc.so
	opt/VirtualBox/VBoxGuestPropSvc.so
	opt/VirtualBox/VBoxHeadless
	opt/VirtualBox/VBoxHeadless.so
	opt/VirtualBox/VBoxKeyboard.so
	opt/VirtualBox/VBoxManage
	opt/VirtualBox/VBoxNetAdpCtl
	opt/VirtualBox/VBoxNetDHCP
	opt/VirtualBox/VBoxNetDHCP.so
	opt/VirtualBox/VBoxOGLhostcrutil.so
	opt/VirtualBox/VBoxOGLhosterrorspu.so
	opt/VirtualBox/VBoxOGLrenderspu.so
	opt/VirtualBox/VBoxPython.so
	opt/VirtualBox/VBoxPython2_5.so
	opt/VirtualBox/VBoxPython2_6.so
	opt/VirtualBox/VBoxPython2_7.so
	opt/VirtualBox/VBoxREM.so
	opt/VirtualBox/VBoxREM32.so
	opt/VirtualBox/VBoxREM64.so
	opt/VirtualBox/VBoxRT.so
	opt/VirtualBox/VBoxSDL
	opt/VirtualBox/VBoxSDL.so
	opt/VirtualBox/VBoxSVC
	opt/VirtualBox/VBoxSettings.so
	opt/VirtualBox/VBoxSharedClipboard.so
	opt/VirtualBox/VBoxSharedCrOpenGL.so
	opt/VirtualBox/VBoxSharedFolders.so
	opt/VirtualBox/VBoxTestOGL
	opt/VirtualBox/VBoxTunctl
	opt/VirtualBox/VBoxVMM.so
	opt/VirtualBox/VBoxVRDP.so
	opt/VirtualBox/VBoxXPCOM.so
	opt/VirtualBox/VBoxXPCOMC.so
	opt/VirtualBox/VBoxXPCOMIPCD
	opt/VirtualBox/VRDPAuth.so
	opt/VirtualBox/VirtualBox
	opt/VirtualBox/VirtualBox.so
	opt/VirtualBox/accessible/libqtaccessiblewidgets.so
	opt/VirtualBox/components/VBoxC.so
	opt/VirtualBox/components/VBoxSVCM.so
	opt/VirtualBox/components/VBoxXPCOMIPCC.so
	opt/VirtualBox/kchmviewer
	opt/VirtualBox/libQtCoreVBox.so.4
	opt/VirtualBox/libQtGuiVBox.so.4
	opt/VirtualBox/libQtNetworkVBox.so.4
	opt/VirtualBox/libQtOpenGLVBox.so.4
	opt/VirtualBox/vboxwebsrv"

PYTHON_UPDATER_IGNORE="1"

src_unpack() {
	unpack_makeself ${MY_P}_${ARCH}.run
	unpack ./VirtualBox.tar.bz2

	mkdir "${S}"/${EXTP_PN} || die
	pushd "${S}"/${EXTP_PN} &>/dev/null || die
	unpack ${EXTP_PN}-${EXTP_PV}.tar.gz
	popd &>/dev/null || die

	if use sdk; then
		unpack VirtualBoxSDK-${SDK_PV}.zip
	fi
}

src_configure() {
	:;
}

src_compile() {
	:;
}

src_install() {
	# create virtualbox configurations files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-config" vbox.cfg

	if ! use headless ; then
		pushd "${S}"/icons &>/dev/null || die
		for size in * ; do
			if [ -f "${size}/virtualbox.png" ] ; then
				insinto "/usr/share/icons/hicolor/${size}/apps"
				newins "${size}/virtualbox.png" ${PN}.png
			fi
		done
		dodir /usr/share/pixmaps
		cp "48x48/virtualbox.png" "${D}/usr/share/pixmaps/${PN}.png" \
			|| die
		popd &>/dev/null || die

		newmenu "${FILESDIR}"/${PN}.desktop-2 ${PN}.desktop
	fi

	pushd "${S}"/${EXTP_PN} &>/dev/null || die
	insinto /opt/VirtualBox/ExtensionPacks/${EXTP_PN}
	doins -r linux.${ARCH}
	doins ExtPack* PXE-Intel.rom
	popd &>/dev/null || die
	rm -rf "${S}"/${EXTP_PN}

	insinto /opt/VirtualBox
	dodir /opt/bin

	doins UserManual.pdf

	if use sdk ; then
		doins -r sdk
	fi

	if use additions; then
		doins -r additions
	fi

	if use vboxwebsrv; then
		doins vboxwebsrv
		fowners root:vboxusers /opt/VirtualBox/vboxwebsrv
		fperms 0750 /opt/VirtualBox/vboxwebsrv
		dosym /opt/VirtualBox/VBox.sh /opt/bin/vboxwebsrv
		newinitd "${FILESDIR}"/vboxwebsrv-initd vboxwebsrv
		newconfd "${FILESDIR}"/vboxwebsrv-confd vboxwebsrv
	fi

	if use rdesktop-vrdp; then
		doins rdesktop-vrdp
		doins -r rdesktop-vrdp-keymaps
		fperms 0750 /opt/VirtualBox/rdesktop-vrdp
		dosym /opt/VirtualBox/rdesktop-vrdp /opt/bin/rdesktop-vrdp
	fi

	if ! use headless && use chm; then
		doins kchmviewer VirtualBox.chm
		fowners root:vboxusers /opt/VirtualBox/kchmviewer
		fperms 0750 /opt/VirtualBox/kchmviewer
	fi

	if use python; then
		local pyver
		for pyver in 2.5 2.6 2.7; do
			if has_version "=dev-lang/python-${pyver}*" && [ -f "${S}/VBoxPython${pyver/./_}.so" ] ; then
				doins VBoxPython${pyver/./_}.so
			fi
		done
	fi

	rm -rf src rdesktop* deffiles install* routines.sh runlevel.sh \
		vboxdrv.sh VBox.sh VBox.png vboxnet.sh additions VirtualBox.desktop \
		VirtualBox.tar.bz2 LICENSE VBoxSysInfo.sh rdesktop* vboxwebsrv \
		webtest kchmviewer VirtualBox.chm vbox-create-usb-node.sh \
		90-vbox-usb.fdi uninstall.sh vboxshell.py vboxdrv-pardus.py \
		VBoxPython?_*.so

	if use headless ; then
		rm -rf VBoxSDL VirtualBox VBoxKeyboard.so
	fi

	doins -r * || die

	# create symlinks for working around unsupported $ORIGIN/.. in VBoxC.so (setuid)
	dosym /opt/VirtualBox/VBoxVMM.so /opt/VirtualBox/components/VBoxVMM.so
	dosym /opt/VirtualBox/VBoxREM.so /opt/VirtualBox/components/VBoxREM.so
	dosym /opt/VirtualBox/VBoxRT.so /opt/VirtualBox/components/VBoxRT.so
	dosym /opt/VirtualBox/VBoxDDU.so /opt/VirtualBox/components/VBoxDDU.so
	dosym /opt/VirtualBox/VBoxXPCOM.so /opt/VirtualBox/components/VBoxXPCOM.so

	local each
	for each in VBox{Manage,SVC,XPCOMIPCD,Tunctl,NetAdpCtl,NetDHCP,TestOGL,ExtPackHelperApp}; do
		fowners root:vboxusers /opt/VirtualBox/${each}
		fperms 0750 /opt/VirtualBox/${each}
		pax-mark -m "${D}"/opt/VirtualBox/${each}
	done
	# VBoxNetAdpCtl and VBoxNetDHCP binaries need to be suid root in any case..
	fperms 4750 /opt/VirtualBox/VBoxNetAdpCtl
	fperms 4750 /opt/VirtualBox/VBoxNetDHCP

	if ! use headless ; then
		# Hardened build: Mark selected binaries set-user-ID-on-execution
		for each in VBox{SDL,Headless} VirtualBox; do
			fowners root:vboxusers /opt/VirtualBox/${each}
			fperms 4510 /opt/VirtualBox/${each}
			pax-mark -m "${D}"/opt/VirtualBox/${each}
		done

		dosym /opt/VirtualBox/VBox.sh /opt/bin/VirtualBox
		dosym /opt/VirtualBox/VBox.sh /opt/bin/VBoxSDL
	else
		# Hardened build: Mark selected binaries set-user-ID-on-execution
		fowners root:vboxusers /opt/VirtualBox/VBoxHeadless
		fperms 4510 /opt/VirtualBox/VBoxHeadless
		pax-mark -m "${D}"/opt/VirtualBox/VBoxHeadless
	fi

	exeinto /opt/VirtualBox
	newexe "${FILESDIR}/${PN}-3-wrapper" "VBox.sh"
	fowners root:vboxusers /opt/VirtualBox/VBox.sh
	fperms 0750 /opt/VirtualBox/VBox.sh

	dosym /opt/VirtualBox/VBox.sh /opt/bin/VBoxManage
	dosym /opt/VirtualBox/VBox.sh /opt/bin/VBoxVRDP
	dosym /opt/VirtualBox/VBox.sh /opt/bin/VBoxHeadless
	dosym /opt/VirtualBox/VBoxTunctl /opt/bin/VBoxTunctl

	# set an env-variable for 3rd party tools
	echo -n "VBOX_APP_HOME=/opt/VirtualBox" > "${T}/90virtualbox"
	doenvd "${T}/90virtualbox"

	local udevdir="$(udev_get_udevdir)"
	insinto ${udevdir}/rules.d
	doins "${FILESDIR}"/10-virtualbox.rules
	sed "s@%UDEVDIR%@${udevdir}@" \
		-i "${D}"${udevdir}/rules.d/10-virtualbox.rules || die
	# move udev scripts into ${udevdir} (bug #372491)
	mv "${D}"/opt/VirtualBox/VBoxCreateUSBNode.sh "${D}"${udevdir} || die
	fperms 0750 ${udevdir}/VBoxCreateUSBNode.sh
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	gnome2_icon_cache_update

	udevadm control --reload-rules && udevadm trigger --subsystem-match=usb

	elog ""
	if ! use headless ; then
		elog "To launch VirtualBox just type: \"VirtualBox\""
		elog ""
	fi
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "For advanced networking setups you should emerge:"
	elog "net-misc/bridge-utils and sys-apps/usermode-utilities"
	elog ""
	elog "Please visit http://www.virtualbox.org/wiki/Editions for"
	elog "an overview about the different features of ${PN}"
	elog "and virtualbox-ose"
	if [ -e "${ROOT}/etc/udev/rules.d/10-virtualbox.rules" ] ; then
		elog ""
		elog "Please remove \"${ROOT}/etc/udev/rules.d/10-virtualbox.rules\""
		elog "or else USB in ${PN} won't work."
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
