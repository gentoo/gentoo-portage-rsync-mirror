# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/tortoisehg/tortoisehg-2.6.2.ebuild,v 1.2 2013/01/04 08:23:56 polynomial-c Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="2.4 3.* *-pypy-*"

inherit distutils eutils

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://bitbucket/${PN}/targz/downloads/${P}.tar.gz"
	HG_DEPEND=">=dev-vcs/mercurial-2.3 <dev-vcs/mercurial-2.5"
else
	inherit mercurial
	EHG_REPO_URI="https://bitbucket.org/tortoisehg/thg"
	KEYWORDS=""
	SRC_URI=""
	HG_DEPEND="dev-vcs/mercurial"
fi

DESCRIPTION="Set of graphical tools for Mercurial"
HOMEPAGE="http://tortoisehg.bitbucket.org"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND="${HG_DEPEND}
	dev-python/iniparse
	dev-python/pygments
	dev-python/PyQt4
	dev-python/qscintilla-python"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-1.0.3 )"

src_prepare() {
	if [[ ${LINGUAS+set} ]]; then
		pushd i18n/tortoisehg > /dev/null || die
		local x y keep
		for x in *.po; do
			keep=false
			for y in ${LINGUAS}; do
				if [[ ${y} == ${x%.po}* ]]; then
					keep=true
					break
				fi
			done
			${keep} || rm "${x}" || die
		done
		popd > /dev/null || die
	fi

	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc ; then
		emake -C doc html
	fi
}

src_install() {
	distutils_src_install
	dodoc doc/ReadMe*.txt doc/TODO

	if use doc ; then
		dohtml -r doc/build/html
	fi

	newicon -s scalable icons/scalable/apps/thg-logo.svg tortoisehg_logo.svg
	domenu contrib/${PN}.desktop
}

pkg_postinst() {
	elog "When startup of ${PN} fails with an API version mismatch error"
	elog "between dev-python/sip and dev-python/PyQt4 please rebuild"
	elog "dev-python/qscintilla-python."
}
