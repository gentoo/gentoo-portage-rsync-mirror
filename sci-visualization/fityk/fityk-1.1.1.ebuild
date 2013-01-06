# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/fityk/fityk-1.1.1.ebuild,v 1.1 2012/02/27 06:07:42 bicatali Exp $

EAPI="4"

WX_GTK_VER="2.9"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
GITHUB_USER="wojdyr"
GITTAG="772ddee"
S="${WORKDIR}/${GITHUB_USER}-${PN}-${GITTAG}"

inherit python wxwidgets autotools fdo-mime

DESCRIPTION="General-purpose nonlinear curve fitting and data analysis"
HOMEPAGE="http://fityk.nieto.pl/"
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gnuplot readline python static-libs wxwidgets"

CDEPEND=">=sci-libs/xylib-0.8
	dev-lang/lua
	readline? ( sys-libs/readline )
	wxwidgets? ( >=x11-libs/wxGTK-2.9.2 )"

DEPEND="${CDEPEND}
	dev-libs/boost
	>=sys-devel/libtool-2.2"

RDEPEND="${CDEPEND}
	gnuplot? ( sci-visualization/gnuplot )"

RESTRICT_PYTHON_ABIS="3.*"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	eautoreconf
	has_version "<dev-libs/boost-1.37" && \
		sed -i -e 's:impl/directives.hpp:directives.ipp:g' \
		"${S}/src/optional_suffix.h"

	sed '/^LTLIBRARIES/s:$(pyexec_LTLIBRARIES)::g' \
		-i swig/Makefile.in
	if use python; then
		echo '#!/bin/sh' > config/py-compile
	fi
}

src_configure() {
	econf  \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--disable-xyconvert \
		$(use_enable python) \
		$(use_enable static-libs static) \
		$(use_enable wxwidgets GUI) \
		$(use_with doc) \
		$(use_with readline)
}

src_compile() {
	use python && python_copy_sources swig
	default
	if use python; then
		compilation() {
			emake \
				PYTHON_CPPFLAGS="-I$(python_get_includedir)" \
				PYTHON_LDFLAGS="$(python_get_library -l)" \
				PYTHON_SITE_PKG="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)" \
				pyexecdir="$(python_get_sitedir)" \
				_fityk.la
		}
		python_execute_function -s --source-dir swig compilation
	fi
}

src_install() {
	default
	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pyexecdir="$(python_get_sitedir)" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir swig installation
		python_clean_installation_image
	fi
}

pkg_postinst() {
	use python && python_mod_optimize ${PN}.py
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	use python && python_mod_cleanup ${PN}.py
	fdo-mime_desktop_database_update
}
