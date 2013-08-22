# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/vlad/vlad-2.6.2.ebuild,v 1.1 2013/08/21 23:52:13 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="considerations.txt History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Pragmatic application deployment automation, without mercy."
HOMEPAGE="http://rubyhitsquad.com/Vlad_the_Deployer.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend ">=dev-ruby/hoe-2.9.2 test? ( dev-ruby/minitest )"
ruby_add_rdepend ">=dev-ruby/rake-remote_task-2.1"

all_ruby_prepare() {
	# Keep Isolate from managing the dependencies.
	sed -i -e '/isolate/ s:^:#:' Rakefile || die
}
