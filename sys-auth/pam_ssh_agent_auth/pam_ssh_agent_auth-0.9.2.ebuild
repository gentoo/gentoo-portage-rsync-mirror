# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_ssh_agent_auth/pam_ssh_agent_auth-0.9.2.ebuild,v 1.2 2011/04/12 07:23:32 angelos Exp $

EAPI=4

inherit eutils pam

DESCRIPTION="Simple module to authenticate users against their ssh-agent keys"
HOMEPAGE="http://pamsshagentauth.sourceforge.net"
SRC_URI="mirror://sourceforge/pamsshagentauth/${PN}/v${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pam
	dev-libs/openssl"

RDEPEND="${DEPEND}
	virtual/ssh"

# needed for pod2man
DEPEND="${DEPEND}
	dev-lang/perl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libs.patch
}

src_configure() {
	pammod_hide_symbols

	econf \
		--libexecdir=$(getpam_mod_dir)
}

src_test() { :; }

src_install() {
	# Don't use emake install as it makes it harder to have proper
	# install paths.
	dopammod pam_ssh_agent_auth.so

	doman pam_ssh_agent_auth.8 || die
}
