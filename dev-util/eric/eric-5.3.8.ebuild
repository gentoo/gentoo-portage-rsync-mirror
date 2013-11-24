# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-5.3.8.ebuild,v 1.1 2013/11/24 22:54:02 pesa Exp $

EAPI=4

PYTHON_DEPEND="3:3.1"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.* *-jython 2.7-pypy-*"

PLOCALES="cs de en es fr it ru tr zh_CN"

inherit eutils l10n python

DESCRIPTION="A full featured Python IDE using PyQt4 and QScintilla"
HOMEPAGE="http://eric-ide.python-projects.org/"

SLOT="5"
MY_PV=${PV/_pre/-snapshot-}
MY_P=${PN}${SLOT}-${MY_PV}

BASE_URI="mirror://sourceforge/eric-ide/${PN}${SLOT}/stable/${PV}"
SRC_URI="${BASE_URI}/${MY_P}.tar.gz"
for L in ${PLOCALES}; do
	SRC_URI+=" linguas_${L}? ( ${BASE_URI}/${PN}${SLOT}-i18n-${L/zh_CN/zh_CN.GB2312}-${MY_PV}.tar.gz )"
done
unset L

LICENSE="GPL-3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="spell"

DEPEND="
	>=dev-python/sip-4.12.4
	>=dev-python/PyQt4-4.9.6-r1[X,help,sql,svg,webkit]
	>=dev-python/qscintilla-python-2.6
"
RDEPEND="${DEPEND}
	>=dev-python/chardet-2.0.1
	>=dev-python/coverage-3.2
	>=dev-python/pygments-1.5
"
PDEPEND="
	spell? ( dev-python/pyenchant )
"

S=${WORKDIR}/${MY_P}

PYTHON_VERSIONED_EXECUTABLES=("/usr/bin/.*")

src_prepare() {
	# Avoid file collisions between different slots of Eric.
	sed -i -e 's/^Icon=eric$/&5/' eric/eric5.desktop || die
	sed -i -e 's/\([^[:alnum:]]\)eric\.png\([^[:alnum:]]\)/\1eric5.png\2/' \
		$(grep -lr 'eric\.png' .) || die
	mv eric/icons/default/eric{,5}.png || die
	mv eric/pixmaps/eric{,5}.png || die
	rm -f eric/APIs/Python/zope-*.api
	rm -f eric/APIs/Ruby/Ruby-*.api

	# Delete internal copies of dev-python/chardet,
	# dev-python/coverage and dev-python/pygments.
	rm -fr eric/ThirdParty
	rm -fr eric/DebugClients/Python{,3}/coverage
	sed -i -e 's/from DebugClients\.Python3\?\.coverage/from coverage/' \
		$(grep -lr 'from DebugClients\.Python3\?\.coverage' .) || die

	# Fix desktop files (bug 458092).
	sed -i -e '/^Categories=/s:Python:X-&:' eric/eric5{,_webbrowser}.desktop || die
}

src_install() {
	installation() {
		"$(PYTHON)" install.py \
			-z \
			-b "${EPREFIX}/usr/bin" \
			-i "${T}/images/${PYTHON_ABI}" \
			-d "${EPREFIX}$(python_get_sitedir)" \
			-c
	}
	python_execute_function installation
	python_merge_intermediate_installation_images "${T}/images"

	doicon eric/icons/default/eric5.png || die
}

pkg_postinst() {
	python_mod_optimize -x "/eric5/(DebugClients/Python|UtilitiesPython2)/" eric5{,config.py,plugins}

	elog
	elog "If you want to use Eric with mod_python, have a look at"
	elog "\"${EROOT}$(python_get_sitedir -b -f)/eric5/patch_modpython.py\"."
	elog
	elog "The following packages will give Eric extended functionality:"
	elog "  dev-python/pylint"
	elog "  dev-python/pysvn"
	elog
	elog "This version has a plugin interface with plugin-autofetch from"
	elog "the application itself. You may want to check those as well."
	elog
}

pkg_postrm() {
	python_mod_cleanup eric5{,config.py,plugins}
}
