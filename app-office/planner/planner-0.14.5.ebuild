# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/planner/planner-0.14.5.ebuild,v 1.3 2012/05/03 20:00:40 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="xz"
PYTHON_DEPEND="python? 2"

inherit python gnome2 eutils autotools

DESCRIPTION="Project manager for Gnome"
HOMEPAGE="http://live.gnome.org/Planner/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="doc eds python examples"

RDEPEND=">=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.14:2
	>=gnome-base/libgnomecanvas-2.10
	>=gnome-base/libgnomeui-2.10
	>=gnome-base/libglade-2.4:2.0
	>=gnome-base/gconf-2.6:2
	>=dev-libs/libxml2-2.6.27:2
	>=dev-libs/libxslt-1.1.23
	python? ( >=dev-python/pygtk-2.6:2 )
	eds? (
		>=gnome-extra/evolution-data-server-1.1
		>=mail-client/evolution-2.1.3 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.35.5
	doc? ( >=dev-util/gtk-doc-1.0 )
	dev-util/gtk-doc-am
	gnome-base/gnome-common"

# FIXME: disable eds backend for now, it fails, upstream bug #654005
pkg_setup() {
	DOCS="AUTHORS COPYING ChangeLog NEWS README"
	G2CONF="${G2CONF}
		$(use_enable python)
		$(use_enable python python-plugin)
		$(use_enable eds)
		--disable-eds-backend
		--with-database=no
		--disable-update-mimedb"
		#$(use_enable eds eds-backend)
	use python && python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in || die "sed failed"

	# Find python in a faster way, bug #344231, upstream bug #654044
	epatch "${FILESDIR}/${PN}-0.14.5-find-python.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_install() {
	gnome2_src_install \
		sqldocdir="\$(datadir)/doc/${PF}" \
		sampledir="\$(datadir)/doc/${PF}/examples"

	if ! use examples; then
		rm -rf "${D}/usr/share/doc/${PF}/examples"
	fi
}
