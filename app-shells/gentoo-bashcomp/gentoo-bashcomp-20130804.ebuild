# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/gentoo-bashcomp/gentoo-bashcomp-20130804.ebuild,v 1.2 2013/08/04 20:27:30 dirtyepic Exp $

EAPI="5"
inherit bash-completion-r1 eutils prefix

DESCRIPTION="Gentoo-specific bash command-line completions (emerge, ebuild, equery, repoman, layman, etc)"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}-r1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris"
IUSE=""

RDEPEND=">=app-shells/bash-completion-2.1-r1"

src_prepare() {
	eprefixify gentoo gentoo-style-init
	epatch_user
}

src_compile() {	:; } # There is a useless Makefile in the distfile

src_install() {
	local sym bashcompdir

	bashcompdir="$(get_bashcompdir)"
	insinto "${bashcompdir}"
	doins gentoo repoman layman
	for sym in emerge ebuild rc rc-status rc-update gcc-config \
		distcc-config java-config browser-config equery ekeyword portageq \
		webapp-config revdep-rebuild splat euse glsa-check epm metagen \
		rc-service; do
		dosym gentoo "${bashcompdir}"/${sym}
	done

	insinto /etc/bash_completion.d
	doins gentoo-style-init

	dodoc AUTHORS ChangeLog TODO
}
