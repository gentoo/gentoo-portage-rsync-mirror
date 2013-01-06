# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rss-glx/rss-glx-0.9.0.ebuild,v 1.6 2012/05/05 04:53:51 jdhore Exp $

EAPI=2
inherit autotools multilib

MY_P=${PN}_${PV}

DESCRIPTION="Really Slick OpenGL Screensavers for XScreenSaver"
HOMEPAGE="http://rss-glx.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ~ppc64 sparc x86"
IUSE="+bzip2 openal"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	>=media-libs/glew-1.5.1
	media-libs/mesa
	>=media-gfx/imagemagick-6.2
	>=x11-misc/xscreensaver-5.08-r2
	bzip2? ( app-arch/bzip2 )
	openal? ( >=media-libs/freealut-1.1.0-r1 )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	virtual/pkgconfig
	sys-apps/sed"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e '/CFLAGS=/s:-O2:${CFLAGS}:' \
		-e '/CXXFLAGS=/s:-O2:${CXXFLAGS}:' \
		-i configure.in || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		--bindir=/usr/$(get_libdir)/misc/xscreensaver \
		--enable-shared \
		--disable-dependency-tracking \
		$(use_enable bzip2) \
		$(use_enable openal sound) \
		--with-configdir=/usr/share/xscreensaver/config
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README*
}

pkg_postinst() {
	local xssconf="${ROOT}usr/share/X11/app-defaults/XScreenSaver"

	if [ -f ${xssconf} ]; then
		sed -e '/*programs:/a\
		GL:       \"Cyclone\"  cyclone --root     \\n\\\
		GL:      \"Euphoria\"  euphoria --root    \\n\\\
		GL:    \"Fieldlines\"  fieldlines --root  \\n\\\
		GL:        \"Flocks\"  flocks --root      \\n\\\
		GL:          \"Flux\"  flux --root        \\n\\\
		GL:        \"Helios\"  helios --root      \\n\\\
		GL:    \"Hyperspace\"  hyperspace --root  \\n\\\
		GL:       \"Lattice\"  lattice --root     \\n\\\
		GL:        \"Plasma\"  plasma --root      \\n\\\
		GL:     \"Skyrocket\"  skyrocket --root   \\n\\\
		GL:    \"Solarwinds\"  solarwinds --root  \\n\\\
		GL:     \"Colorfire\"  colorfire --root   \\n\\\
		GL:   \"Hufos Smoke\"  hufo_smoke --root  \\n\\\
		GL:  \"Hufos Tunnel\"  hufo_tunnel --root \\n\\\
		GL:    \"Sundancer2\"  sundancer2 --root  \\n\\\
		GL:          \"BioF\"  biof --root        \\n\\\
		GL:   \"BusySpheres\"  busyspheres --root \\n\\\
		GL:   \"SpirographX\"  spirographx --root \\n\\\
		GL:    \"MatrixView\"  matrixview --root  \\n\\\
		GL:        \"Lorenz\"  lorenz --root      \\n\\\
		GL:      \"Drempels\"  drempels --root    \\n\\\
		GL:      \"Feedback\"  feedback --root    \\n\\' \
			-i ${xssconf} || die "sed failed"
	fi
}

pkg_postrm() {
	local xssconf="${ROOT}usr/share/X11/app-defaults/XScreenSaver"

	if [ -f ${xssconf} ]; then
		sed \
			-e '/\"Cyclone\"  cyclone/d' \
			-e '/\"Euphoria\"  euphoria/d' \
			-e '/\"Fieldlines\"  fieldlines/d' \
			-e '/\"Flocks\"  flocks/d' \
			-e '/\"Flux\"  flux/d' \
			-e '/\"Helios\"  helios/d' \
			-e '/\"Hyperspace\"  hyperspace/d' \
			-e '/\"Lattice\"  lattice/d' \
			-e '/\"Plasma\"  plasma/d' \
			-e '/\"Skyrocket\"  skyrocket/d' \
			-e '/\"Solarwinds\"  solarwinds/d' \
			-e '/\"Colorfire\"  colorfire/d' \
			-e '/\"Hufos Smoke\"  hufo_smoke/d' \
			-e '/\"Hufos Tunnel\"  hufo_tunnel/d' \
			-e '/\"Sundancer2\"  sundancer2/d' \
			-e '/\"BioF\"  biof/d' \
			-e '/\"BusySpheres\"  busyspheres/d' \
			-e '/\"SpirographX\"  spirographx/d' \
			-e '/\"MatrixView\"  matrixview/d' \
			-e '/\"Lorenz\"  lorenz/d' \
			-e '/\"Drempels\"  drempels/d' \
			-e '/\"Feedback\"  feedback/d' \
			-i ${xssconf} || die "sed failed"
	fi
}
