# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv/ivtv-1.0.3-r2.ebuild,v 1.9 2013/01/21 22:19:30 ssuominen Exp $

inherit eutils linux-mod

DESCRIPTION="ivtv driver for Hauppauge PVR PCI cards"
HOMEPAGE="http://www.ivtvdriver.org"
SRC_URI="http://dl.ivtvdriver.org/ivtv/archive/1.0.x/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="fbcon perl"
RDEPEND="virtual/udev"
DEPEND="app-arch/unzip"
PDEPEND=">=media-tv/ivtv-firmware-20070217
	perl? (
		dev-perl/Video-Frequencies
		dev-perl/Video-ivtv
		dev-perl/Config-IniFiles
		virtual/perl-Getopt-Long
		dev-perl/perl-tk )"

pkg_setup() {

	MODULE_NAMES="saa717x(extra:${S}/i2c-drivers)"
	BUILD_TARGETS="all"
	CONFIG_CHECK="EXPERIMENTAL KMOD HAS_IOMEM FW_LOADER I2C I2C_ALGOBIT
		VIDEO_DEV VIDEO_CAPTURE_DRIVERS VIDEO_V4L1 VIDEO_V4L2
		!VIDEO_HELPER_CHIPS_AUTO VIDEO_IVTV"

	if use fbcon; then
		MODULE_NAMES="${MODULE_NAMES} ivtvfb(extra:${S}/driver)"
		CONFIG_CHECK="${CONFIG_CHECK} FB FB_TRIDENT FRAMEBUFFER_CONSOLE FONTS"
	fi

	if ! ( kernel_is 2 6 22 || kernel_is 2 6 23 ); then
		eerror "Each IVTV driver branch will only work with a specific"
		eerror "linux kernel branch."
		eerror ""
		eerror "You will need to either:"
		eerror "a) emerge a different kernel"
		eerror "b) emerge a different ivtv driver"
		eerror ""
		eerror "See http://ivtvdriver.org/ for more information"
		die "This only works on 2.6.22 and 2.6.23 kernels"
	fi

	if use fbcon; then
		ewarn ""
		ewarn "From the README regarding framebuffer support:"
		ewarn ""
		ewarn "ivtvfb now requires that you enable the following kernel config"
		ewarn "options: Go to 'Device drivers -> Graphics support'. Enable"
		ewarn "'Support for frame buffer devices'. Enable 'Trident support'"
		ewarn "(the Trident module itself is not required)."
		ewarn ""
		ewarn "To get working console output, keep going to 'Console display"
		ewarn "driver support', and enable 'Framebuffer Console support'."
		ewarn "Enable 'Select compiled-in fonts' & once that's done, you should"
		ewarn "have a list of fonts. Choose one. With the default OSD size,"
		ewarn "'VGA 8x16' gives 80x30(PAL) 80x25(NTSC)."
		ewarn ""
		ewarn "This ebuild checks for all the correct kernel config options for"
		ewarn "framebuffer use with the exception of choosing a font.  Be sure"
		ewarn "to pick one yourself!"
		ewarn ""
	fi

	ewarn ""
	ewarn "Make sure that your I2C and V4L kernel drivers are loaded as"
	ewarn "modules, and not compiled into the kernel, or IVTV will not"
	ewarn "work."
	ewarn ""

	linux-mod_pkg_setup

	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_compile() {

	cd "${S}/driver"
	linux-mod_src_compile || die "failed to build driver"

	cd "${S}/utils"
	emake INCDIR="${KV_DIR}/include" || die "failed to build utils "
}

src_install() {
	cd "${S}/utils"
	make DESTDIR="${D}" PREFIX="/usr" install || die "failed to install utils"
	use perl && dobin perl/*.pl

	cd "${S}"
	dodoc README* doc/* ChangeLog*
	use perl && dodoc utils/perl/README.ptune

	cd "${S}/driver"
	linux-mod_src_install || die "failed to install modules"
}

pkg_postinst() {

	linux-mod_pkg_postinst

	elog ""
	elog "This version of the IVTV driver supports the following hardware:"
	elog "Hauppauge WinTV PVR-250"
	elog "Hauppauge WinTV PVR-350"
	elog "Hauppauge WinTV PVR-150"
	elog "Hauppauge WinTV PVR-500"
	elog "AVerMedia M179"
	elog "Yuan MPG600/Kuroutoshikou iTVC16-STVLP"
	elog "Yuan MPG160/Kuroutoshikou iTVC15-STVLP"
	elog "Yuan PG600/DiamondMM PVR-550 (CX Falcon 2)"
	elog "Adaptec AVC-2410"
	elog "Adaptec AVC-2010"
	elog "Nagase Transgear 5000TV"
	elog "AOpen VA2000MAX-STN6"
	elog "Yuan MPG600GR/Kuroutoshikou CX23416GYC-STVLP"
	elog "I/O Data GV-MVP/RX"
	elog "I/O Data GV-MVP/RX2E"
	elog "Gotview PCI DVD (preliminary support only)"
	elog "Gotview PCI DVD2 Deluxe"
	elog "Yuan MPC622"
	elog ""
	ewarn ""
	ewarn "IMPORTANT: In case of problems first read this page:"
	ewarn "http://www.ivtvdriver.org/index.php/Troubleshooting"
	ewarn ""
	ewarn "If any of these conditions match your setup, you may want to look at the"
	ewarn "README in /usr/share/doc/${PF}/"
	ewarn ""
	ewarn " - Using MythTV, a PVR-350 and the ivtvfb module"
	ewarn " - Using the ivtv X driver and the ivtvfb module"
	ewarn " - You want to manually build ivtv against v4l-dvb"
	ewarn ""
	ewarn "Also, the ivtv package comes with lots of documentation regarding setup,"
	ewarn "proper use and debugging utilities."
	ewarn "They are also located in /usr/share/doc/${PF}/"
	ewarn ""
	ewarn "For more information, see the IVTV driver homepage at:"
	ewarn "http://www.ivtvdriver.org/"
}
