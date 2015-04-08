# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fssm/fssm-0.2.10.ebuild,v 1.2 2014/08/18 05:31:54 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"
RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="The File System State Monitor"
HOMEPAGE="https://github.com/ttilley/fssm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_rdepend "dev-ruby/rb-inotify"

all_ruby_prepare() {
	sed -e 's/git ls-files/ls/g' \
		-e 's/{test,spec,features}/spec/g' \
		-e '/s\.executables.*/d' \
		-i ${PN}.gemspec || die "sed failed"
}
