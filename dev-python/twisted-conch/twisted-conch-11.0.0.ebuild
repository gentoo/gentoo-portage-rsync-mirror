# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-11.0.0.ebuild,v 1.10 2012/10/05 14:45:03 marienz Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"
MY_PACKAGE="Conch"

inherit twisted versionator

DESCRIPTION="Twisted SSHv2 implementation"

KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	dev-python/pyasn1
	dev-python/pycrypto"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/conch twisted/plugins"

src_prepare() {
	distutils_src_prepare

	if [[ "${EUID}" -eq 0 ]]; then
		# Disable tests failing with root permissions.
		sed -e "s/test_checkKeyAsRoot/_&/" -i twisted/conch/test/test_checkers.py
		sed -e "s/test_getPrivateKeysAsRoot/_&/" -i twisted/conch/test/test_openssh_compat.py
	fi
}
