# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hub/hub-1.10.4.ebuild,v 1.1 2013/01/10 04:09:49 ottxor Exp $

EAPI="5"

USE_RUBY="ruby18 ruby19"
RUBY_FAKEGEM_TASK_DOC=
RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.md"
RUBY_S="*-${PN}-*"

inherit ruby-fakegem

ruby_add_bdepend "test? ( dev-ruby/webmock dev-util/cucumber )"

DESCRIPTION="command-line wrapper for git that makes you better at GitHub"
HOMEPAGE="http://defunkt.io/hub/"
SRC_URI="https://github.com/defunkt/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
DEPEND=">=dev-vcs/git-1.7.3"

pkg_postinst() {
	einfo "You may want to add 'alias git=hub' to your .bashrc"
}
