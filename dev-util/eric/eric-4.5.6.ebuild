# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eric/eric-4.5.6.ebuild,v 1.4 2012/12/26 03:46:58 pesa Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
# 2.4 and 2.5 are restricted to avoid conditional dependency on dev-python/simplejson.
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython 2.7-pypy-*"

inherit eutils python

SLOT="4"
MY_PN="${PN}${SLOT}"
MY_PV="${PV/_pre/-snapshot-}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A full featured Python IDE using PyQt4 and QScintilla"
HOMEPAGE="http://eric-ide.python-projects.org/"
BASE_URI="mirror://sourceforge/eric-ide/${MY_PN}/stable/${PV}"
SRC_URI="${BASE_URI}/${MY_P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="kde spell"

DEPEND="
	>=dev-python/sip-4.12.4
	|| ( >=dev-python/PyQt4-4.9.6-r1[X,help,svg,webkit]
		<dev-python/PyQt4-4.9.6-r1[X,assistant,svg,webkit] )
	>=dev-python/qscintilla-python-2.3
	kde? ( kde-base/pykde4 )
"
RDEPEND="${DEPEND}
	>=dev-python/chardet-2.0.1
	>=dev-python/coverage-3.0.1
	>=dev-python/pygments-1.3.1
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
	epatch "${FILESDIR}/eric-4.4-no-interactive.patch"
	use kde || epatch "${FILESDIR}/eric-4.4-no-pykde.patch"

	# Delete internal copies of dev-python/chardet, dev-python/coverage,
	# dev-python/pygments and dev-python/simplejson.
	rm -fr eric/ThirdParty
	rm -fr eric/DebugClients/Python{,3}/coverage
	sed -i -e '\|/coverage/|d' eric/${MY_PN}.e4p || die
	sed -i -e 's/from DebugClients\.Python3\?\.coverage /from coverage /' \
		$(grep -lr 'from DebugClients\.Python3\?\.coverage' .) || die
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

	doicon eric/icons/default/eric.png || die
	make_desktop_entry "${MY_PN} --nosplash" ${MY_PN} eric "Development;IDE;Qt"
}

pkg_postinst() {
	python_mod_optimize ${MY_PN}{,config.py,plugins}

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
