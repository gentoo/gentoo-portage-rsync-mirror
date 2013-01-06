# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/fingerprint-gui/fingerprint-gui-1.04.ebuild,v 1.5 2012/10/31 16:10:50 ssuominen Exp $

EAPI=4

inherit eutils multilib qt4-r2 udev

DESCRIPTION="Use Fingerprint Devices with Linux"
HOMEPAGE="http://www.n-view.net/Appliance/fingerprint/"
SRC_URI="http://www.n-view.net/Appliance/fingerprint/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+upekbsapi"

RDEPEND="app-crypt/qca
	app-crypt/qca-ossl
	sys-auth/libfprint
	sys-auth/polkit-qt
	sys-libs/pam
	x11-libs/libfakekey
	x11-libs/qt-core:4
	!sys-auth/thinkfinger"
DEPEND="${RDEPEND}"

QA_SONAME="/usr/lib/libbsapi.so /usr/lib64/libbsapi.so"
QA_PRESTRIPPED="/usr/lib/libbsapi.so /usr/lib64/libbsapi.so"
QA_FLAGS_IGNORED="/usr/lib/libbsapi.so /usr/lib64/libbsapi.so"

src_prepare() {
	epatch "${FILESDIR}"/${P}-unistd.patch
}

src_configure() {
	eqmake4 \
		PREFIX="${EROOT}"usr \
		LIB="$(get_libdir)" \
		LIBEXEC=libexec \
		LIBPOLKIT_QT=LIBPOLKIT_QT_1_1
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	rm -r "${ED}"/usr/share/doc/${PN} || die
	if use upekbsapi ; then
		use amd64 && dolib.so upek/lib64/libbsapi.so
		use x86 && dolib.so upek/lib/libbsapi.so
		udev_dorules upek/91-fingerprint-gui-upek.rules
		insinto /etc
		doins upek/upek.cfg
		#dodir /var/upek_data
		#fowners root:plugdev /var/upek_data
		#fperms 0775 /var/upek_data
	fi

	dodoc CHANGELOG README
	dohtml doc/*
}

pkg_postinst() {
	elog "Please take a thorough look a the Install-step-by-step.html"
	elog "in /usr/share/doc/${PF} for integration with pam/polkit/..."
	elog "Hint: You may want"
	elog "   auth        sufficient  pam_fingerprint-gui.so"
	elog "in /etc/pam.d/system-auth"
	einfo
	elog "There are udev rules to enforce group plugdev on the reader device"
	elog "Please put yourself in that group and re-trigger the udev rules."
}
