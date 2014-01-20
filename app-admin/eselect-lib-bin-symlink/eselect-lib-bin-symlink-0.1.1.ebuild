# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-lib-bin-symlink/eselect-lib-bin-symlink-0.1.1.ebuild,v 1.15 2014/01/20 20:10:01 vapier Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="An eselect library to manage executable symlinks"
HOMEPAGE="https://bitbucket.org/mgorny/eselect-lib-bin-symlink/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="app-admin/eselect"
