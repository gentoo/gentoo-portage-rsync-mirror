# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/osc/osc-0.139.1.ebuild,v 1.4 2013/05/27 16:23:57 miska Exp $

EAPI=5

EGIT_REPO_URI="git://github.com/openSUSE/osc.git"
PYTHON_DEPEND="2:2.6"

if [[ "${PV}" == "9999" ]]; then
	EXTRA_ECLASS="git-2"
else
	OBS_PROJECT="openSUSE:Tools"
	EXTRA_ECLASS="obs-download"
fi

inherit distutils ${EXTRA_ECLASS}
unset EXTRA_ECLASS

DESCRIPTION="Command line tool for Open Build Service"
HOMEPAGE="http://en.opensuse.org/openSUSE:OSC"

[[ "${PV}" == "9999" ]] || SRC_URI="${OBS_URI}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

# Don't move KEYWORDS on the previous line or ekeyword won't work # 399061
[[ "${PV}" == "9999" ]] || \
KEYWORDS="amd64 x86"

DEPEND="
	dev-python/urlgrabber
	dev-python/pyxml
	app-arch/rpm[python]
	dev-python/m2crypto
"
PDEPEND="${DEPEND}
	app-admin/sudo
	dev-util/obs-service-meta
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	dosym osc-wrapper.py /usr/bin/osc
	keepdir /usr/lib/osc/source_validators
	cd "${ED}"/usr/
	find . -type f -exec sed -i 's|/usr/bin/build|/usr/bin/suse-build|g'     {} +
	find . -type f -exec sed -i 's|/usr/lib/build|/usr/libexec/suse-build|g' {} +
	find . -type f -exec sed -i 's|/usr/lib/obs|/usr/libexec/obs|g'          {} +
	rm -f "${ED}"/usr/share/doc/${PN}*/TODO*
}
