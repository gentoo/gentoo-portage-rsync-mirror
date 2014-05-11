# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fssm/fssm-0.2.10.ebuild,v 1.1 2014/05/11 22:20:35 vikraman Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"
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
