# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/childlabor/childlabor-0.0.3.ebuild,v 1.1 2012/06/07 19:43:53 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_DOCDIR=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A scripting framework that replaces rake and sake"
HOMEPAGE="https://github.com/carllerche/childlabor"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# upstream hasn't released a tarball, and the tests are not in the gem
# file.
RESTRICT=test
