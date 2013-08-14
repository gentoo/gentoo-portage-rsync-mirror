# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/megacli/megacli-8.07.07.ebuild,v 1.2 2013/08/14 12:51:40 patrick Exp $

EAPI=5

inherit rpm

DESCRIPTION="LSI Logic MegaRAID Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://www.lsi.com/downloads/Public/MegaRAID%20Common%20Files/${PV}_MegaCLI.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	app-admin/chrpath"
RDEPEND=""

S=${WORKDIR}

RESTRICT="mirror fetch"
QA_PREBUILT="/opt/${PN}/${PN}
	/opt/${PN}/lib/*"

pkg_nofetch() {
	einfo "Upstream has implement a mandatory clickthrough EULA for distfile download"
	einfo "Please visit $SRC_URI"
	einfo "And place $A in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rpm_unpack ./linux/MegaCli-${PV}-1.noarch.rpm
}

src_install() {
	exeinto /opt/megacli
	libsysfs=libstorelibir-2.so.13.05-0
	case ${ARCH} in
		amd64) MegaCli=MegaCli64;;
		x86) MegaCli=MegaCli;;
		*) die "invalid ARCH";;
	esac
	newexe opt/MegaRAID/MegaCli/${MegaCli} ${PN}

	exeinto /opt/${PN}/lib
	doexe opt/MegaRAID/MegaCli/${libsysfs}

	into /opt
	newbin "${FILESDIR}"/${PN}-wrapper ${PN}
	dosym ${PN} /opt/bin/MegaCli

	dodoc ${PV}_MegaCLI.txt

	# Remove DT_RPATH
	chrpath -d "${D}"/opt/${PN}/${PN}
}

pkg_postinst() {
	einfo
	einfo "See /usr/share/doc/${PF}/${PV}_MegaCli.txt for a list of supported controllers"
	einfo "(contains LSI model names only, not those sold by 3rd parties"
	einfo "under custom names like Dell PERC etc)."
	einfo
	einfo "As there's no dedicated manual, you might want to have"
	einfo "a look at the following cheat sheet (originally written"
	einfo "for Dell PowerEdge Expandable RAID Controllers):"
	einfo "http://tools.rapidsoft.de/perc/perc-cheat-sheet.html"
	einfo
	einfo "For more information about working with Dell PERCs see:"
	einfo "http://tools.rapidsoft.de/perc/"
	einfo
}
