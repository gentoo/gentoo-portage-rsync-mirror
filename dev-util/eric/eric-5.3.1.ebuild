# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-5.3.1.ebuild,v 1.1 2013/03/11 09:42:20 patrick Exp $

EAPI="4"
PYTHON_DEPEND="3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.* *-jython 2.7-pypy-*"

inherit eutils python

SLOT="5"
MY_PN="${PN}${SLOT}"
MY_PV="${PV/_pre/-snapshot-}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A full featured Python IDE using PyQt4 and QScintilla"
HOMEPAGE="http://eric-ide.python-projects.org/"
BASE_URI="mirror://sourceforge/eric-ide/${MY_PN}/stable/${PV}"
SRC_URI="${BASE_URI}/${MY_P}.tar.gz"

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

LANGS="cs de en es fr it ru tr zh_CN"
for L in ${LANGS}; do
	SRC_URI+=" linguas_${L}? ( ${BASE_URI}/${MY_PN}-i18n-${L/zh_CN/zh_CN.GB2312}-${MY_PV}.tar.gz )"
	IUSE+=" linguas_${L}"
done
unset L

S=${WORKDIR}/${MY_P}

PYTHON_VERSIONED_EXECUTABLES=("/usr/bin/.*")

src_prepare() {
	# Avoid file collisions between different slots of Eric.
	sed -e "s/^Icon=eric$/&${SLOT}/" -i eric/${MY_PN}.desktop || die
	sed -e "s/\([^[:alnum:]]\)eric\.png\([^[:alnum:]]\)/\1eric5.png\2/" \
		-i $(grep -lr "eric\.png" .) || die
	mv eric/icons/default/eric{,5}.png || die
	mv eric/pixmaps/eric{,5}.png || die
	rm -f eric/APIs/Python/zope-*.api
	rm -f eric/APIs/Ruby/Ruby-*.api

	# Delete internal copies of dev-python/chardet,
	# dev-python/coverage and dev-python/pygments.
	rm -fr eric/ThirdParty
	rm -fr eric/DebugClients/Python{,3}/coverage
	sed -i -e '\|/coverage/|d' eric/${MY_PN}.e4p || die
	sed -i -e 's/from DebugClients\.Python3\?\.coverage /from coverage /' \
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

	doicon eric/icons/default/${MY_PN}.png || die
}

pkg_postinst() {
	python_mod_optimize -x "/eric5/(DebugClients/Python|UtilitiesPython2)/" ${MY_PN}{,config.py,plugins}

	elog
	elog "If you want to use Eric with mod_python, have a look at"
	elog "\"${EROOT}$(python_get_sitedir -b -f)/${MY_PN}/patch_modpython.py\"."
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
	python_mod_cleanup ${MY_PN}{,config.py,plugins}
}
