# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-14.0.0.ebuild,v 1.4 2014/06/03 20:52:10 jer Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit twisted-r1

DESCRIPTION="Twisted SSHv2 implementation"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="
	=dev-python/twisted-core-${TWISTED_RELEASE}*[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

python_prepare_all() {
	if [[ "${EUID}" -eq 0 ]]; then
		# Disable tests failing with root permissions.
		sed -e "s/test_checkKeyAsRoot/_&/" -i twisted/conch/test/test_checkers.py
		sed -e "s/test_getPrivateKeysAsRoot/_&/" -i twisted/conch/test/test_openssh_compat.py
	fi

	distutils-r1_python_prepare_all
}
