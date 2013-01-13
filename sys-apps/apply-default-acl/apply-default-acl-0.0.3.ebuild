# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apply-default-acl/apply-default-acl-0.0.3.ebuild,v 1.1 2013/01/13 01:04:50 pinkbyte Exp $

EAPI=5

DESCRIPTION="Apply default POSIX ACLs to files and directories"
HOMEPAGE="http://michael.orlitzky.com/code/apply-default-acl.php"
SRC_URI="http://michael.orlitzky.com/code/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-apps/acl"
RDEPEND="${DEPEND}"

DOCS=( doc/README )
