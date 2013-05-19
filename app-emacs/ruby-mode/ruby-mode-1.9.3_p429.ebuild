# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ruby-mode/ruby-mode-1.9.3_p429.ebuild,v 1.3 2013/05/19 12:27:13 ago Exp $

EAPI=5

inherit elisp

MY_PV=${PV/_/-}
DESCRIPTION="Emacs major mode for editing Ruby code"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/ruby-${MY_PV}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

S="${WORKDIR}/ruby-${MY_PV}/misc"
DOCS="README"
ELISP_PATCHES="${P}-last-command-char.patch"
SITEFILE="50${PN}-gentoo.el"
