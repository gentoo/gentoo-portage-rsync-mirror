# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-3.4.0.ebuild,v 1.10 2012/10/28 16:38:26 armin76 Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2 eutils autotools

DESCRIPTION="GNOME default icon theme"
HOMEPAGE="http://www.gnome.org/ http://people.freedesktop.org/~jimmac/icons/#git"

SRC_URI="${SRC_URI}
	branding? ( http://www.mail-archive.com/tango-artists@lists.freedesktop.org/msg00043/tango-gentoo-v1.1.tar.gz )"

LICENSE="|| ( LGPL-3 CCPL-Attribution-ShareAlike-3.0 )
	branding? ( CCPL-Sampling-Plus-1.0 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="branding"

RDEPEND=">=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

# FIXME: double check potential LINGUAS problem
pkg_setup() {
	DOCS="AUTHORS NEWS TODO"
	G2CONF="${G2CONF}
		--enable-icon-mapping
		GTK_UPDATE_ICON_CACHE=$(type -P true)"
}

src_prepare() {
	gnome2_src_prepare

	if use branding; then
		for i in 16 22 24 32 48; do
			cp "${WORKDIR}"/tango-gentoo-v1.1/${i}x${i}/gentoo.png \
			"${S}"/gnome//${i}x${i}/places/start-here.png \
			|| die "Copying gentoo logos failed"
		done
	fi

	# Revert upstream commit that is wrongly updating icon cache, upstream bug #642449
	EPATCH_OPTS="-R" epatch "${FILESDIR}/${PN}-2.91.7-update-cache.patch"

	eaclocal --force # workaround for weird autotools.eclass bug #438296, #419933
	eautoreconf
}
