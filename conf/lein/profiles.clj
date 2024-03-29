;; profiles.clj --- This is where you apply your OCD.
;;
;; Copyright (C) 2009-2020 Damon Kwok
;;
;; Author: damon-kwok <damon-kwok@outlook.com>
;; Date: 2020-02-20
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http:;;www.gnu.org/licenses/>.
;;
;; Code:
{
	:user {
		:local-repo #=(str #=(java.lang.System/getenv "HOME")"/.lein/.m2")
		;;:repositories  {"local" {:url #=(str #=(java.lang.System/getenv "HOME")"/.lein/.m2") :releases {:checksum :ignore}}}
		:mirrors {
			"central" {
				:name "aliyun"
				:url "https://maven.aliyun.com/nexus/content/groups/public"
				:repo-manager true
			}
			"clojars" {
				:name "cnnic"
				;;:url "https://mirrors.cnnic.cn/clojars/"
				:url "https://mirrors.tuna.tsinghua.edu.cn/clojars"
				:repo-manager true
			}
		}
    :plugins      []
    :repl-options {:init (use 'midje.repl)}
    ;:injections  [(require 'cemerick.pomegranate.aether)
    ;              (cemerick.pomegranate.aether/register-wagon-factory!
    ;               "http" #(org.apache.maven.wagon.providers.http.HttpWagon.))]
    :dependencies [[midje "1.10.9"]]
	}
}
;;
;; profiles ends here
