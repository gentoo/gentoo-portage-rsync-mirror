# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-pt-br/aspell-pt-br-6.0.20070411.ebuild,v 1.10 2012/05/17 20:06:29 aballier Exp $

ASPELL_LANG="Brazilian Portuguese"
ASPOSTFIX="6"

inherit aspell-dict

FILENAME="aspell6-pt_BR-20070411-0"
SRC_URI="mirror://gnu/aspell/dict/pt_BR/${FILENAME}.tar.bz2"

LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${FILENAME}"

# Contains a conflict
RDEPEND="!<app-dicts/aspell-pt-0.50.2-r1"
