# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libpinyin/libpinyin-0.9.93.ebuild,v 1.2 2015/04/19 11:42:57 blueness Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Library for Chinese pinyin input methods"
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PN}-lite-${PV}.tar.gz -> ${P}.tar
	mirror://sourceforge/${PN}/models/model6.text.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="=sys-libs/db-4*
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	virtual/libintl
	virtual/pkgconfig"

src_prepare() {
	ln -s "${DISTDIR}"/model6.text.tar.gz data || die
	sed -e '/wget/d' -i data/Makefile.am || die
	epatch_user
	eautoreconf
}

src_install() {
	default
	prune_libtool_files
}
