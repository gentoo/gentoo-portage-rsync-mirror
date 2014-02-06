# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-igd/gupnp-igd-0.2.3.ebuild,v 1.1 2014/02/06 22:14:39 eva Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
AUTOTOOLS_AUTORECONF=true

inherit autotools-utils gnome.org python-r1

DESCRIPTION="Library to handle UPnP IGD port mapping for GUPnP"
HOMEPAGE="http://gupnp.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection python"

RDEPEND="
	>=dev-libs/glib-2.26:2
	net-libs/gssdp
	>=net-libs/gupnp-0.18
	introspection? ( >=dev-libs/gobject-introspection-0.10 )
	python? (
		>=dev-libs/gobject-introspection-0.10
		>=dev-python/pygobject-2.16:2[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	sys-devel/gettext
	virtual/pkgconfig
"

# The only existing test is broken
RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/${PN}-0.1.11-disable_static_modules.patch
)

src_prepare() {
	# Python bindings are built/installed manually.
	if use python; then
		sed -e "/PYTHON_SUBDIR =/s/ python//" -i Makefile.am Makefile.in || die
	fi
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-static
		--disable-gtk-doc
		$(use_enable introspection)
		$(use_enable python)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile

	if use python; then
		python_copy_sources

		building() {
			cd "${BUILD_DIR}"/python || die
			emake \
				PYTHON_INCLUDES="-I$(python_get_includedir)" \
				pyexecdir="$(python_get_sitedir)"
		}
		python_foreach_impl building
	fi
}

src_install() {
	autotools-utils_src_install

	if use python; then
		installation() {
			cd "${BUILD_DIR}"/python || die
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				install
		}
		python_foreach_impl installation
	fi
}
