# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/subsurface/subsurface-9999.ebuild,v 1.3 2013/11/16 15:15:16 tomwij Exp $

EAPI="5"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://subsurface.hohndel.org/subsurface.git"
	GIT_ECLASS="git-2"
	LIBDC_V="0.4.1"
else
	SRC_URI="http://subsurface.hohndel.org/downloads/Subsurface-${PV}.tgz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	LIBDC_V="0.4.1"
	S="${WORKDIR}/${P/s/S}"
fi

inherit eutils qt4-r2 ${GIT_ECLASS}

DESCRIPTION="An open source dive log program"
HOMEPAGE="http://subsurface.hohndel.org"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc usb"
for LINGUA in ${LINGUAS}; do
	IUSE+=" linguas_${LINGUA}"
done

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libxml2:2
	dev-libs/libxslt:0
	dev-libs/libzip:0
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	kde-base/marble:4
"
DEPEND="${RDEPEND}
	>=dev-libs/libdivecomputer-${LIBDC_V}[static-libs,usb?]
	virtual/pkgconfig
	doc? ( app-text/asciidoc )
"

DOCS="README"

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-2_src_unpack
	else
		unpack ${A}
	fi
}

src_compile() {
	emake CC="$(tc-getCC)"

	if use doc; then
		cd "Documentation" && emake user-manual.xhtml
	fi
}

src_install() {
	qt4-r2_src_install

	if use doc; then
		mv "${ED}/usr/share/doc/${PN}/"* "${ED}/usr/share/doc/${PF}/". || die "doc mv failed"
	fi
	rm -Rf "${ED}/usr/share/doc/${PN}"
}
