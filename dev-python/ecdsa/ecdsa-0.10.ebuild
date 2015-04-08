# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ecdsa/ecdsa-0.10.ebuild,v 1.16 2015/04/08 08:05:01 mgorny Exp $

EAPI=5

# pypy has test failures with some BadSignatureErrors
PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="ECDSA cryptographic signature library in pure Python"
HOMEPAGE="http://github.com/warner/python-ecdsa"
SRC_URI="https://github.com/warner/python-${PN}/tarball/python-${P} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~ppc ~ppc64 ~s390 ~sparc x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint"
IUSE=""
