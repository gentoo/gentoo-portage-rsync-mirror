# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-igd/gupnp-igd-0.2.2.ebuild,v 1.3 2012/11/25 17:22:08 eva Exp $

EAPI="5"
PYTHON_DEPEND="python? 2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit autotools eutils gnome.org python

DESCRIPTION="This is a library to handle UPnP IGD port mapping for GUPnP."
HOMEPAGE="http://gupnp.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection python"

RDEPEND="
	>=net-libs/gupnp-0.18
	>=dev-libs/glib-2.16:2
	introspection? ( >=dev-libs/gobject-introspection-0.10 )
	python? ( >=dev-python/pygobject-2.16:2 )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	sys-devel/gettext
	virtual/pkgconfig
"

# The only existing test is broken
RESTRICT="test"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.1.11-disable_static_modules.patch
	eautoreconf

	# Python bindings are built/installed manually.
	if use python; then
		sed -e "/PYTHON_SUBDIR =/s/ python//" -i Makefile.am Makefile.in || die
		python_clean_py-compile_files -q
	fi
}

src_configure() {
	econf \
		--disable-static \
		--disable-gtk-doc \
		$(use_enable introspection) \
		$(use_enable python)
}

src_compile() {
	default

	if use python; then
		python_copy_sources python

		building() {
			emake \
				PYTHON_INCLUDES="-I$(python_get_includedir)" \
				pyexecdir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	DOCS="AUTHORS NEWS README TODO"

	default

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir python installation

		python_clean_installation_image
	fi

	prune_libtool_files
}

pkg_postinst() {
	if use python; then
		python_mod_optimize gupnp
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup gupnp
	fi
}
