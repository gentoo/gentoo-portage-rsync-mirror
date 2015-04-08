# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-names/twisted-names-13.2.0.ebuild,v 1.6 2015/03/21 08:42:30 jer Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit twisted-r1

DESCRIPTION="A Twisted DNS implementation"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="=dev-python/twisted-core-${TWISTED_RELEASE}*[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
