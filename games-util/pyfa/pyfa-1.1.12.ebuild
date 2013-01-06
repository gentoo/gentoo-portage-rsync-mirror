# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/pyfa/pyfa-1.1.12.ebuild,v 1.1 2012/12/09 21:37:27 tetromino Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite,threads"

inherit eutils gnome2-utils python-r1

if [[ ${PV/_rc*/} == ${PV} ]] ; then
	MY_PV=${PV}-retribution-1.0.2-src
	FOLDER=pyfa/stable/${PV}
else
	MY_PV=${PV/_rc/-stable-RC}-src
	FOLDER=pyfa/stable/${PV/*_rc/RC}
fi

DESCRIPTION="Python Fitting Assistant - a ship fitting application for EVE Online"
HOMEPAGE="http://www.evefit.org/static/pyfa"
SRC_URI="http://dl.evefit.org/${FOLDER}/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-3+ LGPL-2.1+ CCPL-Attribution-2.5 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+graph"

RDEPEND="dev-python/sqlalchemy
	dev-python/wxpython:2.8
	graph? ( dev-python/matplotlib[wxwidgets] dev-python/numpy )
	${PYTHON_DEPS}"
DEPEND="app-text/dos2unix
	${PYTHON_DEPS}"

S=${WORKDIR}/${PN}

src_prepare() {
	# get rid of CRLF line endings introduced in 1.1.10 so patches work
	dos2unix config.py pyfa.py service/settings.py || die

	# make staticPath settable from configforced again
	epatch "${FILESDIR}/${PN}-1.1-staticPath.patch"

	# use correct slot of wxpython, http://trac.evefit.org/ticket/475
	epatch "${FILESDIR}/${PN}-1.1.4-wxversion.patch"

	# do not try to save exported html to python sitedir
	epatch "${FILESDIR}/${PN}-1.1.8-html-export-path.patch"

	# fix import path in the main script for systemwide installation
	epatch "${FILESDIR}/${PN}-1.1.11-import-pyfa.patch"
	touch __init__.py

	pyfa_make_configforced() {
		mkdir -p "${BUILD_DIR}" || die
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			-e "s:%%EPREFIX%%:${EPREFIX}:" \
			"${FILESDIR}/configforced.py" > "${BUILD_DIR}/configforced.py"
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			pyfa.py > "${BUILD_DIR}/pyfa"
	}
	python_foreach_impl pyfa_make_configforced
}

src_install() {
	pyfa_py_install() {
		local packagedir=$(python_get_sitedir)/${PN}
		insinto "${packagedir}"
		doins -r eos gui icons service config*.py info.py __init__.py gpl.txt
		doins "${BUILD_DIR}/configforced.py"
		python_doscript "${BUILD_DIR}/pyfa"
		python_optimize
	}
	python_foreach_impl pyfa_py_install

	insinto /usr/share/${PN}
	doins -r staticdata
	dodoc readme.txt
	insinto /usr/share/icons/hicolor/32x32/apps
	doins icons/pyfa.png
	insinto /usr/share/icons/hicolor/64x64/apps
	newins icons/pyfa64.png pyfa.png
	domenu "${FILESDIR}/${PN}.desktop"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
