# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libpinyin/libpinyin-0.8.0.ebuild,v 1.1 2013/01/31 12:39:48 yngwin Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Library for Chinese pinyin input methods"
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="mirror://github/${PN}/${PN}/${PN}-lite-${PV}.tar.gz -> ${P}.tar
	mirror://github/${PN}/${PN}/model.text.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=sys-libs/db-4*
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	virtual/libintl
	virtual/pkgconfig"

src_prepare() {
	ln -s "${DISTDIR}"/model.text.tar.gz data || die
	sed -e '/wget/d' -i data/Makefile.am || die
	epatch_user
	eautoreconf
}

src_install() {
	default
	prune_libtool_files
}
