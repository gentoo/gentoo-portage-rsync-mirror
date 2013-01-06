# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-www/guile-www-2.34.ebuild,v 1.5 2012/09/09 14:57:54 armin76 Exp $

EAPI=4

inherit eutils

DESCRIPTION="Guile Scheme modules to facilitate HTTP, URL and CGI programming"
HOMEPAGE="http://www.nongnu.org/guile-www/"
SRC_URI="mirror://nongnu/guile-www/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-scheme/guile-1.8"
DEPEND="${RDEPEND}"
