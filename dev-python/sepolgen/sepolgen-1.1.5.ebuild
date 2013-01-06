# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sepolgen/sepolgen-1.1.5.ebuild,v 1.4 2012/06/26 05:00:43 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"

inherit python

DESCRIPTION="SELinux policy generation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120216/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=sys-libs/libselinux-2.0[python]
		app-admin/setools[python]"
RDEPEND="${DEPEND}"

src_prepare() {
	# fix up default paths to not be RH specific
	sed -i -e 's:/usr/share/selinux/devel:/usr/share/selinux/strict:' \
		"${S}/src/sepolgen/defaults.py" || die
	sed -i -e 's:/usr/share/selinux/devel:/usr/share/selinux/strict/include:' \
		"${S}/src/sepolgen/module.py" || die
}

src_compile() {
	:
}

src_test() {
	if has_version sec-policy/selinux-base-policy; then
		python_src_test
	else
		ewarn "Sepolgen requires sec-policy/selinux-base-policy to run tests."
	fi
}

src_install() {
	installation() {
		emake DESTDIR="${D}" PYTHONLIBDIR="$(python_get_sitedir)" install
	}
	python_execute_function installation
}

pkg_postinst() {
	python_mod_optimize sepolgen
}

pkg_postrm() {
	python_mod_cleanup sepolgen
}
