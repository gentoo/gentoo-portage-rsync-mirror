# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdf2djvu/pdf2djvu-0.7.16.ebuild,v 1.2 2013/03/17 13:22:13 ssuominen Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="A tool to create DjVu files from PDF files"
HOMEPAGE="http://code.google.com/p/pdf2djvu/"
SRC_URI="http://pdf2djvu.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+graphicsmagick nls openmp test"

RDEPEND="
	>=app-text/djvu-3.5.21:=
	>=app-text/poppler-0.16.7:=
	dev-libs/libxml2:=
	dev-libs/libxslt:=
	graphicsmagick? ( media-gfx/graphicsmagick:= )
"
DEPEND="${RDEPEND}
	dev-cpp/pstreams
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	test? ( dev-python/nose )
"

REQUIRED_USE="test? ( graphicsmagick )"

src_configure() {
	local openmp=--disable-openmp
	use openmp && tc-has-openmp && openmp=--enable-openmp

	econf \
		${openmp} \
		$(use_enable nls) \
		$(use_with graphicsmagick)
}

src_install() {
	default
	dodoc doc/{changelog,{cjk,credits,djvudigital}.txt}
}
