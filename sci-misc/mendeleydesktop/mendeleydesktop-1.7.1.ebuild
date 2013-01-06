# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/mendeleydesktop/mendeleydesktop-1.7.1.ebuild,v 1.1 2012/11/28 22:50:12 miknix Exp $

EAPI="4"

inherit eutils multilib

MY_P_AMD64="${P}-linux-x86_64"
MY_P_X86="${P}-linux-i486"

DESCRIPTION="A free research management tool for desktop and web"
HOMEPAGE="http://www.mendeley.com/"
SRC_URI="amd64? ( ${MY_P_AMD64}.tar.bz2 )
	x86? ( ${MY_P_X86}.tar.bz2 )
	amd64-linux? ( ${MY_P_AMD64}.tar.bz2 )
	x86-linux? ( ${MY_P_X86}.tar.bz2 )"

LICENSE="Mendeley-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"

DEPEND=""
RDEPEND=">=x11-libs/qt-core-4.6:4
	>=x11-libs/qt-gui-4.6:4
	>=x11-libs/qt-svg-4.6:4
	>=x11-libs/qt-webkit-4.6:4
	>=x11-libs/qt-xmlpatterns-4.6:4"

QA_PRESTRIPPED="
	/opt/mendeleydesktop/$(get_libdir)/mendeleydesktop/libexec/.*
	/opt/mendeleydesktop/$(get_libdir)/lib.*so.*"

pkg_nofetch() {
	elog "Please download ${A} from:"
	elog "http://www.mendeley.com/download-mendeley-desktop/"
	elog "and move it to ${DISTDIR}"
}

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}"

	if use amd64 || use amd64-linux ; then
		mv -f "${MY_P_AMD64}" "${P}"
	else
		mv -f "${MY_P_X86}" "${P}"
	fi
}

src_prepare() {
	# remove bundled Qt libraries
	rm -rf lib/mendeleydesktop/plugins \
		|| die "failed to remove plugin directory"
	rm -rf lib/qt || die "failed to remove qt libraries"

	# force use of system Qt libraries
	sed -i "s:sys\.argv\.count(\"--force-system-qt\") > 0:True:" \
		bin/mendeleydesktop || die "failed to patch startup script"

	# fix library paths
	sed -i \
		-e "s:lib/mendeleydesktop:$(get_libdir)/mendeleydesktop:g" \
		-e "s:MENDELEY_BASE_PATH + \"/lib/\":MENDELEY_BASE_PATH + \"/$(get_libdir)/\":g" \
		bin/mendeleydesktop || die "failed to patch library path"
}

src_install() {
	# install menu
	domenu share/applications/${PN}.desktop

	# install application icons
	insinto /usr/share/icons
	doins -r share/icons/hicolor

	# install default icon
	insinto /usr/share/pixmaps
	doins share/icons/hicolor/48x48/apps/${PN}.png

	# install documentation, but no license file
	dodoc share/doc/${PN}/FAQ.pdf
	dodoc share/doc/${PN}/Readme.txt

	# install binary
	into /opt/${PN}
	dobin bin/*

	# install libraries
	dolib.so lib/lib*.so*

	# install programs
	exeinto /opt/mendeleydesktop/$(get_libdir)/mendeleydesktop/libexec
	doexe lib/mendeleydesktop/libexec/*

	# install shared files
	insinto /opt/${PN}/share
	doins -r share/mendeleydesktop

	# make symbolic to known location
	dosym /opt/${PN}/bin/${PN} /opt/bin/${PN}
}
