# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glyr/glyr-1.0.1.ebuild,v 1.1 2013/05/26 07:41:59 radhermit Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="A music related metadata searchengine, both with commandline interface and C API"
HOMEPAGE="http://github.com/sahib/glyr"
SRC_URI="https://github.com/sahib/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.10:2
	net-misc/curl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS README*" # CHANGELOG is obsolete in favour of git history

src_prepare() {
	sed -e 's:-Os -s::' -e 's:-ggdb3::' -i CMakeLists.txt || die
}
