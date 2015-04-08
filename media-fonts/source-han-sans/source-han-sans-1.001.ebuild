# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/source-han-sans/source-han-sans-1.001.ebuild,v 1.1 2015/03/14 05:07:43 yngwin Exp $

EAPI=5
inherit font

# Note to maintainers:
# The upstream tarball is huge (over 780 MB), so we repackage the
# regional subset OTF fonts per region, for the user's convenience.

DESCRIPTION="Pan-CJK OpenType/CFF font family"
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans/"
SRC_URI="linguas_ja? ( http://dev.gentoo.org/~yngwin/distfiles/${PN}-ja-${PV}.tar.xz )
	linguas_ko? ( http://dev.gentoo.org/~yngwin/distfiles/${PN}-ko-${PV}.tar.xz )
	linguas_zh_CN? ( http://dev.gentoo.org/~yngwin/distfiles/${PN}-zh_CN-${PV}.tar.xz )
	linguas_zh_TW? ( http://dev.gentoo.org/~yngwin/distfiles/${PN}-zh_TW-${PV}.tar.xz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x64-macos"
IUSE="linguas_ja linguas_ko +linguas_zh_CN linguas_zh_TW"
REQUIRED_USE="|| ( linguas_ja linguas_ko linguas_zh_CN linguas_zh_TW )"

S=${WORKDIR}
FONT_SUFFIX="otf"
RESTRICT="binchecks strip"

src_install() {
	for l in ja ko zh_CN zh_TW; do
		use linguas_${l} && FONT_S="${S}/source-han-sans-${l}-${PV}" font_src_install
	done
	dodoc source-han-sans-*-${PV}/*md source-han-sans-*-${PV}/*pdf
}
