# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/po-mode/po-mode-0.18.1.1.ebuild,v 1.9 2012/05/09 01:46:29 aballier Exp $

inherit elisp

DESCRIPTION="Major mode for GNU gettext PO files"
HOMEPAGE="http://www.gnu.org/software/gettext/"
SRC_URI="mirror://gnu/gettext/gettext-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

S="${WORKDIR}/gettext-${PV}/gettext-tools/misc"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	elisp-compile po-mode.el po-compat.el || die
}
