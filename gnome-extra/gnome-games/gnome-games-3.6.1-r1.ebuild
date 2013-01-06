# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-3.6.1-r1.ebuild,v 1.5 2013/01/01 14:32:21 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="xml"

# Make sure games is inherited first so that the gnome2
# functions will be called if they are not overridden
inherit games gnome2 python-r1 virtualx

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/GnomeGames/"

LICENSE="GPL-2 GPL-3 FDL-1.1"
SLOT="0"
# TODO: file KEYWORDREQ bug once it's determined that seed is usable
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~x86"

# FIXME: we should decide whether to have USE flag for games or features
# IUSE="artworkextra clutter opengl python test"
# vs
# IUSE="artworkextra aisleriot glchess quadrapassel swell-foop lightsoff gnibbles sudoku"
IUSE="artworkextra +aisleriot +clutter +glchess +sudoku test"

COMMON_DEPEND="
	>=dev-libs/glib-2.25.7
	>=gnome-base/librsvg-2.32
	>=x11-libs/cairo-1.10
	>=x11-libs/gtk+-3.3.11:3[introspection]

	>=media-libs/libcanberra-0.26[gtk3]

	artworkextra? ( >=gnome-extra/gnome-games-extra-data-3 )
	clutter? (
		media-libs/clutter:1.0[introspection]
		>=media-libs/clutter-gtk-0.91.6:1.0 )
	glchess? (
		dev-db/sqlite:3
		virtual/glu
		virtual/opengl
		x11-libs/libX11 )
	sudoku? ( dev-libs/gobject-introspection )
"
RDEPEND="${COMMON_DEPEND}
	sudoku? (
		${PYTHON_DEPS}
		dev-python/pycairo
		dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
		x11-libs/gdk-pixbuf:2[introspection]
		x11-libs/pango[introspection]
		>=x11-libs/gtk+-3:3[introspection] )

	!<gnome-extra/gnome-games-extra-data-3
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.4
	dev-util/itstool
	>=sys-devel/gettext-0.10.40
	virtual/pkgconfig
"

# For compatibility with older versions of the gnome-games package
PDEPEND="aisleriot? ( games-board/aisleriot )"

# Others are installed below; multiples in this package.
DOCS="AUTHORS HACKING MAINTAINERS TODO"

_omitgame() {
	G2CONF="${G2CONF},${1}"
}

pkg_setup() {
	# create the games user / group
	games_pkg_setup
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	if use sudoku ; then
		python_copy_sources
	fi
}

src_configure() {
	G2CONF="${G2CONF}
		--disable-static
		ITSTOOL=$(type -P true)
		VALAC=$(type -P true)
		--with-platform=gnome
		--with-scores-group=${GAMES_GROUP}
		--enable-omitgames=none" # This line should be last for _omitgame

	# FIXME: Use REQUIRED_USE once games.eclass is ported to EAPI 4
	if ! use clutter; then
		ewarn "USE='-clutter' => quadrapassel, swell-foop, lightsoff, gnibbles won't be installed"
		_omitgame quadrapassel
		_omitgame gnibbles
		_omitgame swell-foop
		_omitgame lightsoff
	fi

	if ! use glchess; then
		_omitgame glchess
	fi

	if ! use sudoku; then
		_omitgame gnome-sudoku
	fi

	if use sudoku ; then
		python_foreach_impl run_in_build_dir gnome2_src_configure
	else
		gnome2_src_configure
	fi
}

src_compile() {
	if use sudoku ; then
		python_foreach_impl run_in_build_dir gnome2_src_compile
	else
		gnome2_src_compile
	fi
}

src_test() {
	if use sudoku ; then
		python_foreach_impl run_in_build_dir Xemake check
	else
		Xemake check || die "tests failed"
	fi
}

src_install() {
	if use sudoku ; then
		install_python() {
				gnome2_src_install
				python_doscript gnome-sudoku/src/gnome-sudoku
		}
		python_foreach_impl run_in_build_dir install_python
	else
		gnome2_src_install
	fi

	# Documentation install for each of the games
	for game in \
	$(find . -maxdepth 1 -type d ! -name po ! -name libgames-support); do
		docinto ${game}
		for doc in AUTHORS ChangeLog NEWS README TODO; do
			[ -s ${game}/${doc} ] && dodoc ${game}/${doc}
		done
	done
}

pkg_preinst() {
	gnome2_pkg_preinst
	# Avoid overwriting previous .scores files
	local basefile
	for scorefile in "${ED}"/var/lib/games/*.scores; do
		basefile=$(basename $scorefile)
		if [ -s "${EROOT}/var/lib/games/${basefile}" ]; then
			cp "${EROOT}/var/lib/games/${basefile}" \
			"${ED}/var/lib/games/${basefile}"
		fi
	done
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null || die
	"$@"
	popd > /dev/null
}
