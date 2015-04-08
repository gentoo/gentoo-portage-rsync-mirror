# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/echoe/echoe-4.6.5.ebuild,v 1.14 2014/10/29 19:00:31 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_EXTRAINSTALL="vendor"

RUBY_FAKEGEM_GEMSPEC="echoe.gemspec"

inherit ruby-fakegem

DESCRIPTION="Packaging tool that provides Rake tasks for common operations"
HOMEPAGE="https://github.com/evan/echoe"

LICENSE="AFL-3.0 MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/allison dev-ruby/rubyforge )"
ruby_add_rdepend "dev-ruby/rubyforge dev-ruby/allison >=dev-ruby/rake-0.9.2 >=dev-ruby/rdoc-3.6.1"

all_ruby_prepare() {
	# gemcutter is an optional dependency that is not important for
	# Gentoo itself.
	sed -i '/gemcutter/d' echoe.gemspec || die
}
