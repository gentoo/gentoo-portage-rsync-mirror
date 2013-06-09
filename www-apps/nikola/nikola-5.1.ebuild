# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nikola/nikola-5.1.ebuild,v 1.4 2013/06/09 19:03:24 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} ) # 3_2 should be possible now, but untested
inherit distutils-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="http://nikola.ralsina.com.ar/"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/ralsina/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://nikola-generator.googlecode.com/files/${P}.zip"
	KEYWORDS="~amd64"
fi

LICENSE="MIT-with-advertising"
SLOT="0"
IUSE="jinja markdown"

DEPEND="dev-python/docutils" # needs rst2man to build manpage
RDEPEND="${DEPEND}
	=dev-python/configparser-3.2.0*
	>=dev-python/doit-0.20.0
	virtual/python-imaging
	dev-python/lxml
	>=dev-python/mako-0.6
	>=dev-python/mock-1.0.0
	dev-python/pygments
	dev-python/PyRSS2Gen
	dev-python/requests
	dev-python/unidecode
	dev-python/yapsy
	jinja? ( dev-python/jinja )
	markdown? ( dev-python/markdown )"

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc README.md docs/*.txt
}

pkg_postinst() {
	if has_version '<www-apps/nikola-5.0'; then
		elog 'Nikola has changed quite a lot since the previous major version.'
		elog 'Please make sure to read the updated documentation.'
	fi
}
