# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/childlabor/childlabor-0.0.3-r1.ebuild,v 1.2 2014/03/11 20:10:22 johu Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_DOCDIR=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A scripting framework that replaces rake and sake"
HOMEPAGE="https://github.com/carllerche/childlabor"
COMMIT_ID="6518b939dddbad20c7f05aa075d76e3ca6e70447"
SRC_URI="https://github.com/carllerche/childlabor/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RUBY_S="${PN}-${COMMIT_ID}"

ruby_add_bdepend "test? ( dev-ruby/rspec )"

each_ruby_test() {
	${RUBY} -I. -Ilib -S rspec spec/task_spec.rb || die
}
