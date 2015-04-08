# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/merb-core/merb-core-1.1.3-r1.ebuild,v 1.3 2014/11/01 09:29:33 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

# Tools to generate docs are missing from gem distribution.
RUBY_FAKEGEM_TASK_DOC="doc:rdoc"

# Specs use a convoluted scheme to handle multiple ruby implementations
# (and getting it wrong) and dependencies are missing
# (e.g. memcache). Skip for now.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG PUBLIC_CHANGELOG README TODO"

inherit ruby-fakegem

DESCRIPTION="Pocket rocket web framework"
HOMEPAGE="http://merbivore.com"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/rspec )"

ruby_add_rdepend "dev-ruby/bundler
	>=dev-ruby/erubis-2.6.2
	>=dev-ruby/extlib-0.9.13
	>=dev-ruby/mime-types-1.16
	dev-ruby/rack
	dev-ruby/rake"

all_ruby_prepare() {
	# Remove unpackaged tool so that we can use the Rakefile.
	sed -i -e '/annotation_extract/d' -e 's#spec/rake/spectask#rspec/core/rake_task#'\
		-e 's#Spec::Rake::SpecTask#RSpec::Core::RakeTask#' Rakefile || die

	# Avoid obsolete rake task.
	sed -i -e 's:rake/rdoctask:rdoc/task:' Rakefile || die
}
