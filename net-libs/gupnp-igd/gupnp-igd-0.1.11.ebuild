# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-igd/gupnp-igd-0.1.11.ebuild,v 1.4 2012/05/05 02:54:30 jdhore Exp $

EAPI="3"
PYTHON_DEPEND="python? 2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit autotools eutils python

DESCRIPTION="This is a library to handle UPnP IGD port mapping for GUPnP."
HOMEPAGE="http://gupnp.org"
SRC_URI="http://www.gupnp.org/sites/all/files/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection python"

RDEPEND=">=net-libs/gupnp-0.13.2
	!>=net-libs/gupnp-0.17
	>=dev-libs/glib-2.16:2
	introspection? ( >=dev-libs/gobject-introspection-0.10 )
	python? ( >=dev-python/pygobject-2.16:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	dev-util/gtk-doc-am"

# The only existing test is broken
RESTRICT="test"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.1.11-disable_static_modules.patch

	# Disable byte-compilation of Python modules.
	echo "#!/bin/sh" > py-compile

	# Python bindings are built/installed manually.
	sed -e "/PYTHON_SUBDIR =/s/ python//" -i Makefile.am

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		--disable-gtk-doc \
		$(use_enable introspection) \
		$(use_enable python)
}

src_compile() {
	# introspection is built in the same directory and libtool does not handle
	# well dependency like this
	MAKEOPTS="${MAKEOPTS} -j1" default

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
	emake DESTDIR="${D}" install || die

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

	dodoc AUTHORS NEWS README TODO || die
	find "${D}" -name "*.la" -delete
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
