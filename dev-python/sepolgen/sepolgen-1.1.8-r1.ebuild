# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sepolgen/sepolgen-1.1.8-r1.ebuild,v 1.2 2013/04/11 17:52:00 swift Exp $

EAPI="3"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-*"

inherit python eutils

DESCRIPTION="SELinux policy generation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20120924/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/sepolgen/patchbundle-sepolgen-1.1.8-r1.tar.gz"

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

	EPATCH_MULTI_MSG="Applying sepolgen patches ... " \
	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/gentoo-patches" \
	EPATCH_FORCE="yes" \
	epatch

	epatch_user
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
