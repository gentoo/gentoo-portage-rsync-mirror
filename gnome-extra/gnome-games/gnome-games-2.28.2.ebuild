# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.28.2.ebuild,v 1.19 2014/01/16 15:58:56 blueness Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"
WANT_AUTOMAKE="1.11"
PYTHON_DEPEND="2"

# make sure games is inherited first so that the gnome2
# functions will be called if they are not overridden
inherit games games-ggz eutils gnome2 python virtualx autotools

DESCRIPTION="Collection of games for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/GnomeGames/"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="artworkextra guile opengl sdl test" # introspection

# Introspection support needs
#	media-libs/clutter
#	>=dev-libs/gobject-introspection 0.6.3
# and generates GnomeGames...gir
RDEPEND="
	>=dev-games/libggz-0.0.14
	>=dev-games/ggz-client-libs-0.0.14
	>=dev-libs/dbus-glib-0.75
	>=dev-libs/glib-2.6.3:2
	>=dev-libs/libxml2-2.4.0:2
	>=dev-python/gconf-python-2.17.3
	>=dev-python/pygobject-2:2
	>=dev-python/pygtk-2.14:2
	>=dev-python/pycairo-1
	>=gnome-base/gconf-2:2
	>=gnome-base/librsvg-2.14:2
	sys-libs/zlib
	>=x11-libs/cairo-1
	>=x11-libs/gtk+-2.16:2
	x11-libs/libSM

	!sdl? ( media-libs/libcanberra[gtk] )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-mixer[vorbis] )
	guile? ( >=dev-scheme/guile-1.6.5[deprecated,regex] )
	artworkextra? ( gnome-extra/gnome-games-extra-data )
	opengl? (
		dev-python/pygtkglext
		>=dev-python/pyopengl-3 )
	!games-board/glchess"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40.4
	>=sys-devel/gettext-0.10.40
	>=sys-devel/libtool-2
	>=gnome-base/gnome-common-2.12.0
	>=app-text/scrollkeeper-0.3.8
	>=app-text/gnome-doc-utils-0.10
	test? ( >=dev-libs/check-0.9.4 )"

# Others are installed below; multiples in this package.
DOCS="AUTHORS HACKING MAINTAINERS TODO"

# dang make-check fails on docs with -j > 1.  Restrict them for the moment until
# it can be chased down.
RESTRICT="test"

_omitgame() {
	G2CONF="${G2CONF},${1}"
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	# create the games user / group
	games_pkg_setup

	# Decide the sound backend to use - GStreamer gets preference over SDL
	if use sdl; then
		G2CONF="${G2CONF} --with-sound=sdl_mixer"
	else
		G2CONF="${G2CONF} --with-sound=libcanberra"
	fi

	# Needs "seed", which needs gobject-introspection, libffi, etc.
	#$(use_enable clutter)
	#$(use_enable clutter staging)
	#$(use_enable introspection)
	G2CONF="${G2CONF}
		$(use_enable test tests)
		--disable-silent-rules
		--disable-introspection
		--disable-card-themes-installer
		--with-scores-group=${GAMES_GROUP}
		--enable-noregistry=\"${GGZ_MODDIR}\"
		--with-platform=gnome
		--with-card-theme-formats=all
		--with-smclient
		--enable-omitgames=none" # This line should be last for _omitgame

	# Needs clutter, always disable till we can have that
	#if ! use clutter; then
		_omitgame lightsoff
		_omitgame gnometris
		_omitgame same-gnome-clutter
	#fi

	if ! use guile; then
		ewarn "USE='-guile' implies that Aisleriot won't be installed"
		_omitgame aisleriot
	fi

	if ! use opengl; then
		ewarn "USE=-opengl implies that glchess won't be installed"
		_omitgame glchess
	fi
}

src_prepare() {
	python_clean_py-compile_files
	python_convert_shebangs -r 2 .

	# Fix implicit declaration of yylex.
	epatch "${FILESDIR}/${PN}-2.26.3-implicit-declaration.patch"

	# Fix bug #281718 -- *** glibc detected *** gtali: free(): invalid pointer
	epatch "${FILESDIR}/${PN}-2.26.3-gtali-invalid-pointer.patch"

	# Fix build failure, conflicting types for 'games_sound_init',
	# in libgames-support/games_sound.c.
	epatch "${FILESDIR}/${PN}-2.28.1-conflicting-types-libgames-support.patch"

	# fix underlinking
	epatch "${FILESDIR}"/${P}-underlinking.patch

	# Fix build failure with automake 1.11.2. #425208
	epatch "${FILESDIR}"/${P}-automake.patch

	# Fix more underlinking, #497114
	epatch "${FILESDIR}/${P}-zlib.patch"

	# If calling eautoreconf, this ebuild uses libtool-2
	eautoreconf

	gnome2_src_prepare
}

src_test() {
	Xemake check || die "tests failed"
}

src_install() {
	gnome2_src_install

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
	for scorefile in "${D}"/var/lib/games/*.scores; do
		basefile=$(basename $scorefile)
		if [ -s "${ROOT}/var/lib/games/${basefile}" ]; then
			cp "${ROOT}/var/lib/games/${basefile}" \
			"${D}/var/lib/games/${basefile}"
		fi
	done
}

pkg_postinst() {
	games_pkg_postinst
	games-ggz_update_modules
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize gnome_sudoku
	if use opengl; then
		python_mod_optimize glchess
	fi
}

pkg_postrm() {
	games-ggz_update_modules
	gnome2_pkg_postrm
	python_mod_cleanup gnome_sudoku
	if use opengl; then
		python_mod_cleanup glchess
	fi
}
