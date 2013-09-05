# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rarfile/rarfile-2.6.ebuild,v 1.2 2013/09/05 18:47:11 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Module for RAR archive reading"
HOMEPAGE="https://github.com/markokr/rarfile"
SRC_URI="mirror://pypi/r/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compressed"

RDEPEND="${DEPEND}
	compressed? ( || ( app-arch/unrar app-arch/rar ) )"
