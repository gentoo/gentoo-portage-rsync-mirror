# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ruby-mode/ruby-mode-1.8.6.ebuild,v 1.11 2009/11/24 21:18:53 fauli Exp $

inherit elisp

DESCRIPTION="Emacs major mode for editing Ruby code"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/ruby-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SITEFILE=50${PN}-gentoo.el
S="${WORKDIR}/ruby-${PV}/misc"
