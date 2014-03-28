# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythondialog/pythondialog-3.0.1.ebuild,v 1.1 2014/03/28 07:05:15 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A Python module for making simple text/console-mode user interfaces."
HOMEPAGE="http://pythondialog.sourceforge.net/"
SRC_URI="mirror://sourceforge/pythondialog//${PV}/python3-${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-util/dialog"
RDEPEND="${DEPEND}"
