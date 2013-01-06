# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/stellarium/stellarium-0.11.3.ebuild,v 1.8 2012/08/21 20:36:48 mr_bones_ Exp $

EAPI=4
CMAKE_MIN_VERSION="2.4.7"

inherit cmake-utils eutils flag-o-matic

DESCRIPTION="Stellarium renders 3D photo-realistic skies in real time"
HOMEPAGE="http://www.stellarium.org/"
SRC_URI="mirror://sourceforge/stellarium/${P}.tar.gz
	stars? (
		mirror://sourceforge/stellarium/stars_4_1v0_0.cat
		mirror://sourceforge/stellarium/stars_5_2v0_0.cat
		mirror://sourceforge/stellarium/stars_6_2v0_0.cat
		mirror://sourceforge/stellarium/stars_7_2v0_0.cat
		mirror://sourceforge/stellarium/stars_8_2v0_0.cat
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug nls stars"
RESTRICT="test"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/freetype:2
	>=x11-libs/qt-core-4.6.0:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-script:4
	x11-libs/qt-svg:4
	x11-libs/qt-test:4
	media-fonts/dejavu
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	x11-libs/libXt"
DOCS=( AUTHORS ChangeLog README )

LANGS=( af ak am ar as ast az be bg bn bo br bs
ca cs cy da de el en en_CA en_GB en_US eo es et eu fa fi
fil fr fy ga gd gl gu he hi hr hu hy ia id is it ja
ka kk kn ko ky la lb lo lt lv mk ml mn mr ms mt nan nb nl nn oc
pa pl pt pt_BR ro ru sco se si sk sl sq sr sv sw ta te tg th tl
tr tt uk uz vi zh_CN zh_HK zh_TW zu )
for X in "${LANGS[@]}" ; do
	IUSE="${IUSE} linguas_${X}"
done

src_prepare() {
	sed -e '/aa ab ae/d' -e "/GETTEXT_CREATE_TRANSLATIONS/a \ ${LINGUAS}" \
		-i po/stellarium{,-skycultures}/CMakeLists.txt || die #403647
	epatch "${FILESDIR}"/${P}-desktop.patch
	use debug || append-cppflags -DQT_NO_DEBUG #415769
}

src_configure() {
	local mycmakeargs=( $(cmake-utils_use_enable nls NLS) )
	CMAKE_IN_SOURCE_BUILD=1 cmake-utils_src_configure
}

src_install() {
	default

	# use the more up-to-date system fonts
	rm "${ED}"/usr/share/stellarium/data/DejaVuSans{Mono,}.ttf || die
	dosym ../../fonts/dejavu/DejaVuSans.ttf /usr/share/stellarium/data/DejaVuSans.ttf
	dosym ../../fonts/dejavu/DejaVuSansMono.ttf /usr/share/stellarium/data/DejaVuSansMono.ttf

	if use stars ; then
		insinto /usr/share/${PN}/stars/default
		doins "${DISTDIR}"/stars_[45678]_[12]v0_0*.cat
	fi
	newicon doc/images/stellarium-logo.png ${PN}.png
}
